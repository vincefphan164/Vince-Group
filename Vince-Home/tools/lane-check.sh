#!/usr/bin/env bash
# lane-check.sh — ai dang giu cong?
for l in GO CLAUDE; do
  f="Plan/$l-LANE.md"
  if [ -f "$f" ]; then
    b=$(grep -m1 '^BUSY:' "$f" | cut -d: -f2- | tr -d ' ')
    x=$(grep -m1 '^NEXT:' "$f" | cut -d: -f2- | tr -d ' ')
    printf '%-7s BUSY=%-8s NEXT=%s\n' "$l" "$b" "$x"
  else printf '%-7s (khong co %s)\n' "$l" "$f"; fi
done
