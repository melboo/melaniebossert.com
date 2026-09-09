#!/usr/bin/env bash
# Set the splash password. Usage: ./set-password.sh "your password"
# The password is stored only as a SHA-256 hash in index.html.
# Matching is case-insensitive and ignores surrounding spaces.
set -euo pipefail

if [ $# -lt 1 ] || [ -z "$1" ]; then
  echo "Usage: ./set-password.sh \"your password\"" >&2
  exit 1
fi

pw="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
hash="$(printf '%s' "$pw" | shasum -a 256 | cut -d' ' -f1)"

# Replace whatever hash is currently on the HASH line.
/usr/bin/sed -i '' -E "s/var HASH = \"[^\"]*\";/var HASH = \"${hash}\";/" index.html

echo "Password set to: $1"
echo "Hash written to index.html"
echo
echo "Now commit and push:"
echo "  git add index.html && git commit -m 'Change password' && git push"
