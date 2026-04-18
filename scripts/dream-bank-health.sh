#!/bin/bash
# Quick health check for the persistent dream image bank.
# Run periodically (or before a dream publish run) to see whether the bank
# is functioning as a long-memory layer or just accumulating dust.
set -euo pipefail

BANK="$(cd "$(dirname "$0")/.." && pwd)/memory/dream-image-bank.md"

if [ ! -f "$BANK" ]; then
  echo "no image bank found at $BANK"
  exit 1
fi

active_count=$(awk '/^## Active Images/,/^## Consumed Images/' "$BANK" | grep -c '^### ' || true)
consumed_count=$(awk '/^## Consumed Images/,EOF' "$BANK" | grep -c '^### ' || true)

oldest_active_date=$(awk '
  /^## Active Images/      { in_active = 1; next }
  /^## Consumed Images/    { in_active = 0 }
  in_active && /\*\*Last surfaced:\*\*/ {
    match($0, /[0-9]{4}-[0-9]{2}-[0-9]{2}/)
    if (RSTART) print substr($0, RSTART, RLENGTH)
  }
' "$BANK" | sort | head -1)

today=$(date +%Y-%m-%d)
days_since_oldest=""
if [ -n "$oldest_active_date" ]; then
  if days_since_oldest=$(( ( $(date -j -f "%Y-%m-%d" "$today" +%s) - $(date -j -f "%Y-%m-%d" "$oldest_active_date" +%s) ) / 86400 )) 2>/dev/null; then
    :
  else
    days_since_oldest="?"
  fi
fi

echo "dream image bank — $BANK"
echo "  active:    $active_count   (cap: 25)"
echo "  consumed:  $consumed_count"
if [ -n "$oldest_active_date" ]; then
  echo "  oldest active last-surfaced: $oldest_active_date  (${days_since_oldest}d ago)"
fi

if [ "$active_count" -gt 25 ]; then
  echo
  echo "WARN: active list is over the 25-entry cap; next dream publish should prune"
fi

if [ -n "$days_since_oldest" ] && [ "$days_since_oldest" != "?" ] && [ "$days_since_oldest" -gt 30 ]; then
  echo
  echo "WARN: oldest active image is >30 days old without recurrence; should be pruned"
fi

if [ "$consumed_count" -eq 0 ] && [ "$active_count" -gt 5 ]; then
  echo
  echo "NOTE: no consumed images yet. The bank is accumulating but no posts have"
  echo "      drawn from it. Either dreams aren't producing post-worthy seeds, or"
  echo "      full runs aren't checking the bank when picking topics."
fi
