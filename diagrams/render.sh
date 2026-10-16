#!/bin/sh
# Re-render diagram PNGs from their Mermaid sources.
cd "$(dirname "$0")"
for f in *.mmd; do
  w=800; [ "$f" = overview.mmd ] && w=1000
  npx -y @mermaid-js/mermaid-cli@11.4.2 -i "$f" -o "${f%.mmd}.png" -b white -s 2 -w "$w"
done
