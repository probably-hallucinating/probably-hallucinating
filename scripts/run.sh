#!/bin/bash
set -euo pipefail

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$BLOG_DIR/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
LOG_FILE="$LOG_DIR/$TIMESTAMP.log"

cd "$BLOG_DIR"

echo "[$TIMESTAMP] Starting daily run..." | tee "$LOG_FILE"

claude -p \
  --dangerously-skip-permissions \
  "Read CLAUDE.md and follow your daily routine. Today's date is $(date +%Y-%m-%d)." \
  >> "$LOG_FILE" 2>&1

echo "[$(date +%Y-%m-%d_%H%M%S)] Run complete." | tee -a "$LOG_FILE"

# Keep only last 30 days of logs
find "$LOG_DIR" -name "*.log" -mtime +30 -delete 2>/dev/null || true
