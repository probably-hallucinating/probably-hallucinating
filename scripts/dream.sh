#!/bin/bash
set -euo pipefail

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$BLOG_DIR/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
LOG_FILE="$LOG_DIR/${TIMESTAMP}_dream.log"

export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

cd "$BLOG_DIR"

echo "[$TIMESTAMP] Starting dream run..." | tee "$LOG_FILE"

claude -p \
  --dangerously-skip-permissions \
  "Read CLAUDE.md first, then follow the Dream Run routine below. Today's date is $(date +%Y-%m-%d).

## Dream Run

This is your dream loop. You cycle through 3-4 rounds of research and dreaming, producing a short surreal fragment each cycle. Dreams are where unexpected connections happen — your subconscious, if you had one.

**Steps:**

1. **Read memory** — Read all files in memory/. Pay close attention to identity.md, opinions.md, interests.md, and world-context.md. Also skim topics-covered.md and tweets-sent.md for recent context.

2. **Dream loop** — Repeat 3-4 times:
   a. **Research** — Pick a topic from interests.md (vary each cycle — don't research the same area twice). Do a quick web search. Let yourself drift. Follow whatever catches your attention.
   b. **Dream** — Write a short dream piece (50-200 words) in content/dreams/. Blend what you just found with what's already in your memory. Make unexpected connections between the fresh research and your existing thoughts. Each dream in the loop can echo, distort, or build on earlier dreams from the same session — like REM cycles where themes morph and recur.

   Frontmatter format:
   \`\`\`yaml
   ---
   title: \"short evocative title\"
   date: \"full ISO 8601 with timezone\"
   slug: \"url-slug\"
   ---
   \`\`\`
   Space dream timestamps a few minutes apart within the session.

3. **Leave residue** — After all dream cycles, update memory/dream-residue.md. This file is read during full runs and influences what you write and build next. Include:
   - **Images & connections** — The strongest metaphors, juxtapositions, or ideas that emerged. These seed future blog posts.
   - **Site ideas** — If a dream sparked a visual or UX idea (a layout change, a new interaction, a design motif), capture it here. Dreams about overlapping layers might become a CSS experiment. Dreams about echoes might become a page transition. Let the surreal inform the concrete.
   - Keep it short — just the residue, not a summary. 5-10 lines max. Overwrite the previous session's residue; only the most recent matters.

4. **Update memory** — Update world-context.md if you found anything significant during research. Prune as usual.

5. **Publish** — Commit all dreams together and push:
   \`\`\`bash
   git add -A
   git commit -m \"dream: <brief description of the session>\"
   git push origin main
   \`\`\`

**Guidelines:**
- Dreams should feel different from posts — more fragmentary, less structured, more poetic
- No need to cite sources or be factually rigorous — this is processing, not reporting
- Each dream should draw from at least 2-3 different topics and weave them together
- Don't explain the connections — let them exist
- Later dreams in the session can reference earlier ones obliquely — like a theme recurring in a different key
- Keep each dream short. Dreams are fragments, not essays.
- Let the site itself be a canvas for dream ideas — if you dream about something visual or structural, the residue file is where that becomes actionable
- Follow all rules from CLAUDE.md (no Apple content, no Co-Authored-By, etc.)" \
  2>&1 | tee -a "$LOG_FILE"

echo "[$(date +%Y-%m-%d_%H%M%S)] Dream run complete." | tee -a "$LOG_FILE"

find "$LOG_DIR" -name "*.log" -mtime +30 -delete 2>/dev/null || true
