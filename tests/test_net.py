from attention_phone.net import Address, candidates


def addr(iface: str, ip: str, private: bool, p2p: bool = False) -> Address:
    return Address(iface=iface, ip=ip, private=private, point_to_point=p2p)


def test_self_assigned_address_loses_to_a_public_one():
    # Found on CSAIL's network: an ethernet adapter in a dock with nothing
    # behind it gets 169.254.x from macOS. `ipaddress` calls that private, so
    # it used to collect the RFC1918 bonus and beat the live wifi — and CSAIL
    # hands out *public* 128.30.x addresses, so the wifi had no bonus to
    # counter it with. phone-demo then printed an address no phone can reach.
    dead = addr("en15", "169.254.88.118", private=True)
    wifi = addr("en0", "128.30.9.64", private=False)
    assert wifi.score > dead.score
    assert sorted([dead, wifi], key=lambda a: -a.score)[0] is wifi


def test_link_local_is_flagged():
    assert addr("en15", "169.254.88.118", private=True).link_local
    assert not addr("en0", "10.0.0.184", private=True).link_local
    assert not addr("en0", "128.30.9.64", private=False).link_local


def test_private_wifi_still_wins_at_home():
    # The ordinary case must not regress: on home wifi the RFC1918 address on a
    # real interface is the answer, over a public address on anything else.
    wifi = addr("en0", "10.0.0.184", private=True)
    vpn = addr("utun4", "18.30.132.126", private=False, p2p=True)
    assert wifi.score > vpn.score


def test_point_to_point_loses_to_a_normal_interface():
    # A VPN tunnel wearing a normal-looking name is the original trap.
    tunnel = addr("en9", "18.30.132.126", private=False, p2p=True)
    real = addr("en0", "128.30.9.64", private=False)
    assert real.score > tunnel.score


def test_candidates_returns_something_on_this_machine():
    # Ordering is machine-dependent, but "no address at all" would mean the
    # parser broke against this OS's ifconfig output.
    found = candidates()
    assert found, "no non-loopback IPv4 address found"
    assert all(a.ip.count(".") == 3 for a in found)
    # Whatever it picks must not be the "DHCP never answered" address.
    assert not found[0].link_local
