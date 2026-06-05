#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
TARGET="${TARGET:-$HOME}"
MODE="dry"  # dry | apply | remove

case "${1-}" in
--apply) MODE="apply" ;;
--remove) MODE="remove" ;;
"") MODE="dry" ;;
*) echo "Usage: $0 [--apply|--remove]"; exit 2 ;;
esac

cd "$REPO_ROOT*

for d in */; do
pkg="${d%/}"
[ "$pkg" = ".git" ] && continue
if [ "$MODE" = "dry" ]; then
stow -nv -t "$TARGET" "$pkg"
elif [ "$MODE" = "apply" ]; then
stow -v -t "$TARGET" "$pkg"
else
stow -v -D -t "$TARGET" "$pkg"
fi
done