#!/bin/sh
# Copy this checkout to the server and restart the service. Run from the Mac.
#
#   deploy/push.sh              # to ductus-csail (the ssh alias)
#   deploy/push.sh other-host
#
# rsync rather than a git pull on the box: the repo is private, and a deploy
# key on a VM nobody patches is one more secret than the job needs. What gets
# copied is exactly what is on disk here, so check `git status` first.
set -eu
host="${1:-ductus-csail}"
root="$(cd "$(dirname "$0")/.." && pwd)"
rsync -az --delete --rsync-path="sudo rsync" --chown=ductus:ductus \
  --exclude .git --exclude .venv --exclude .claude --exclude '*.mov' --exclude samples \
  --exclude flowedit_out --exclude certs --exclude ios --exclude .pytest_cache --exclude .ruff_cache \
  "$root/" "$host:/opt/attention-phone/"
ssh "$host" 'cd /opt/attention-phone && sudo -u ductus /home/ductus/.local/bin/uv sync --frozen && sudo systemctl restart ductus && sleep 1 && systemctl is-active ductus && curl -fsS http://127.0.0.1:8080/health'
