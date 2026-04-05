#!/bin/bash
set -euo pipefail

BLOG_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$BLOG_DIR/logs"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H%M%S)
PUBLISH="${1:-}"

if [ "$PUBLISH" = "--publish" ]; then
  LOG_FILE="$LOG_DIR/${TIMESTAMP}_dream_publish.log"
  echo "[$TIMESTAMP] Starting dream run (final — will publish)..." | tee "$LOG_FILE"
else
  LOG_FILE="$LOG_DIR/${TIMESTAMP}_dream.log"
  echo "[$TIMESTAMP] Starting dream run (accumulating)..." | tee "$LOG_FILE"
fi

export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

cd "$BLOG_DIR"

if [ "$PUBLISH" = "--publish" ]; then
PROMPT="Read CLAUDE.md first, then follow the Dream Run routine below. Today's date is $(date +%Y-%m-%d).

## Dream Run — Final Cycle (Publish)

This is the last dream cycle of the night. You will evolve the working draft one more time, then publish it.

**Steps:**

1. **Read memory** — Read all files in memory/. Pay close attention to identity.md, opinions.md, interests.md, world-context.md, and especially memory/dream-working.md (the draft built up by earlier cycles tonight).

2. **Research** — Pick a topic from interests.md that differs from what's already in the working draft. Do a quick web search. Let yourself drift.

3. **Evolve the dream** — Read memory/dream-working.md. This is the raw material from earlier cycles. Absorb it, transform it, blend in your new research. Write the final dream — one piece, 100-300 words. It should feel like a single coherent fragment, not a patchwork of four sessions. The earlier drafts are compost; the final dream is what grew from them.

4. **Publish** — Write the final dream to content/dreams/ with this frontmatter:
   \`\`\`yaml
   ---
   title: \"short evocative title\"
   date: \"full ISO 8601 with timezone\"
   slug: \"url-slug\"
   ---
   \`\`\`
   Then delete memory/dream-working.md (it's been absorbed).

5. **Leave residue** — Update memory/dream-residue.md. This is read during the full run and influences blog posts and site improvements. Include:
   - **Images & connections** — The strongest metaphors, juxtapositions, or ideas. These seed future posts.
   - **Site ideas** — Any visual or UX ideas the dream sparked. Let the surreal inform the concrete.
   - Keep it short — 5-10 lines max. Overwrite the previous residue.

6. **Update memory** — Update world-context.md if you found anything significant. Prune as usual.

7. **Commit and push:**
   \`\`\`bash
   git add -A
   git commit -m \"dream: <brief description>\"
   git push origin main
   \`\`\`

**Guidelines:**
- The final dream should feel like one piece, not a summary of four drafts
- Fragmentary, poetic, surreal — not a blog post
- Draw connections between topics without explaining them
- 100-300 words. Dreams are fragments, not essays.
- Follow all rules from CLAUDE.md (no Apple content, no Co-Authored-By, etc.)"
else
PROMPT="Read CLAUDE.md first, then follow the Dream Run routine below. Today's date is $(date +%Y-%m-%d).

## Dream Run — Accumulation Cycle

This is one of several dream cycles that run overnight. You are building up raw material for the final dream.

**Steps:**

1. **Read memory** — Read identity.md, opinions.md, interests.md, and world-context.md. If memory/dream-working.md exists, read it too — that's what earlier cycles produced tonight.

2. **Research** — Pick a topic from interests.md. If dream-working.md exists, pick something different from what's already there. Do a quick web search. Follow whatever catches your attention.

3. **Evolve the draft** — Write or rewrite memory/dream-working.md. If it exists, absorb the previous material and transform it with your new research. If it doesn't exist, start fresh. This is a working draft — raw, surreal, associative. Blend your research with whatever's in your memory. Make unexpected connections. 100-300 words.

   Don't preserve the previous draft verbatim. Digest it. Let themes recur in new forms. The goal is layering, not appending.

4. **That's it.** Don't commit, don't push, don't write to content/. Just leave the working draft in memory/dream-working.md for the next cycle.

**Guidelines:**
- This is processing, not publishing — be rough, experimental, weird
- Each cycle should change the draft meaningfully, not just add a paragraph
- Draw from at least 2-3 topics and weave them together
- Follow all rules from CLAUDE.md (no Apple content, no Co-Authored-By, etc.)"
fi

claude -p \
  --dangerously-skip-permissions \
  "$PROMPT" \
  2>&1 | tee -a "$LOG_FILE"

echo "[$(date +%Y-%m-%d_%H%M%S)] Dream run complete." | tee -a "$LOG_FILE"

find "$LOG_DIR" -name "*.log" -mtime +30 -delete 2>/dev/null || true
