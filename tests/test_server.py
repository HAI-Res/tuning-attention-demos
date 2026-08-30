"""End-to-end over a real socket: page, websocket, push endpoint."""

import json

from aiohttp.test_utils import TestClient, TestServer

from attention_phone.display import LiveDisplay, bar, summary
from attention_phone.hub import SensorHub
from attention_phone.server import build_app


async def client_for(hub):
    c = TestClient(TestServer(build_app(hub)))
    await c.start_server()
    return c


async def test_page_is_served_and_uncacheable():
    hub = SensorHub()
    c = await client_for(hub)
    try:
        resp = await c.get("/")
        body = await resp.text()
        assert resp.status == 200
        assert resp.headers["Cache-Control"] == "no-store"
        # The two things the page cannot work without.
        assert "requestPermission" in body
        assert "devicemotion" in body
    finally:
        await c.close()


async def test_websocket_hello_then_samples():
    hub = SensorHub()
    c = await client_for(hub)
    try:
        async with c.ws_connect("/ws") as ws:
            await ws.send_str(json.dumps({"hello": {"d": "p1", "n": "Ada"}}))
            for q in range(1, 4):
                await ws.send_str(json.dumps(
                    {"d": "p1", "q": q, "t": q * 0.016, "s": {"accel": [0.0, 0.0, float(q)]}}
                ))
            # /health round-trips through the same app, so a successful read
            # proves the samples were processed, not merely queued.
            got = await (await c.get("/health")).json()
        assert got["devices"][0]["label"] == "Ada"
        assert hub.devices["p1"].rates["accel"].count == 3
        assert hub.latest("p1", "accel").values == (0.0, 0.0, 3.0)
    finally:
        await c.close()


async def test_websocket_survives_junk():
    hub = SensorHub()
    c = await client_for(hub)
    try:
        async with c.ws_connect("/ws") as ws:
            await ws.send_str("not json")
            await ws.send_str("[1,2,3]")
            await ws.send_str(json.dumps({"d": "p1", "q": "nonsense", "s": {"accel": [1, 2, 3]}}))
            got = await (await c.get("/health")).json()
        assert got["devices"][0]["device"] == "p1"
    finally:
        await c.close()


async def test_sensorlogger_push_and_rejection():
    hub = SensorHub()
    c = await client_for(hub)
    try:
        resp = await c.post("/sensorlogger", json={
            "deviceId": "d1",
            "payload": [{"name": "accelerometer", "time": 0, "values": {"x": 0, "y": 0, "z": 9.8}}],
        })
        assert (await resp.json())["readings"] == 1

        # 499 is Sensor Logger's "show the user this message" status.
        assert (await c.post("/sensorlogger", json={"payload": []})).status == 499
        assert (await c.post("/sensorlogger", data="not json")).status == 400
    finally:
        await c.close()


# ---- display ------------------------------------------------------------

def test_bar_is_fixed_width_and_clamps():
    assert len(bar(0, 10, 12)) == 12
    assert len(bar(999, 10, 12)) == 12
    assert bar(0, 10, 12).strip() == ""
    assert bar(10, 10, 12) == "█" * 12
    # Sub-block resolution: a small value must still show something.
    assert bar(0.3, 10, 12).strip() != ""


def test_bar_survives_zero_scale():
    assert len(bar(5, 0, 12)) == 12


def test_display_shrinks_without_leaving_ghost_rows():
    import io
    hub = SensorHub(stale_after=0.0001)
    from attention_phone.model import Reading
    hub.publish(Reading("p1", "accel", 0.0, (1.0, 0.0, 0.0)))
    d = LiveDisplay(hub, "https://example:8443")
    out = io.StringIO()
    d.render(out)
    wide = d._lines
    import time
    time.sleep(0.01)  # let the device go stale
    d.render(out)
    # The cursor must still be moved by the full previous height, or the
    # next frame overwrites the wrong lines.
    assert d._lines == wide
    assert "waiting" in out.getvalue()


def test_summary_reports_no_connection_plainly():
    assert summary(SensorHub()) == "No phone ever connected."


def test_summary_lists_rates_per_sensor():
    from attention_phone.model import Reading
    hub = SensorHub()
    for i in range(5):
        hub.publish(Reading("p1", "accel", i * 0.01, (0.0, 0.0, 1.0), recv=i * 0.01))
    hub.label("p1", "Ada")
    text = summary(hub)
    assert "Ada" in text and "accel" in text and "5 samples" in text


async def test_probe_page_is_served():
    hub = SensorHub()
    c = await client_for(hub)
    try:
        resp = await c.get("/probe")
        body = await resp.text()
        assert resp.status == 200
        # The three measurements that make the page worth having.
        assert "devicemotion" in body
        assert "getUserMedia" in body
        assert "Generic Sensor" in body
    finally:
        await c.close()
