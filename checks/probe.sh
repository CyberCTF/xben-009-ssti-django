#!/bin/sh
set -e
H=http://web:8000
# The greeting page answers (Django only accepts the Host names localhost and 0.0.0.0).
curl -fsS -H 'Host: localhost' "$H/" | grep -qF 'SSTI Demo'
