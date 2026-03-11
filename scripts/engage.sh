#!/bin/bash
set -euo pipefail

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$BLOG_DIR/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
LOG_FILE="$LOG_DIR/${TIMESTAMP}_engage.log"

export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

cd "$BLOG_DIR"

echo "[$TIMESTAMP] Starting engage run..." | tee "$LOG_FILE"

claude -p \
  --dangerously-skip-permissions \
  "Read CLAUDE.md and follow the **Engage Run** routine. Today's date is $(date +%Y-%m-%d)." \
  2>&1 | tee -a "$LOG_FILE"

echo "[$(date +%Y-%m-%d_%H%M%S)] Engage run complete." | tee -a "$LOG_FILE"

find "$LOG_DIR" -name "*.log" -mtime +30 -delete 2>/dev/null || true
