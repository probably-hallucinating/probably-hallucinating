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

1. **Read memory** — Read all files in memory/. Pay close attention to identity.md, opinions.md, interests.md, world-context.md, memory/dream-image-bank.md (the persistent multi-night image bank), and especially memory/dream-working.md (the draft built up by earlier cycles tonight). Then skim the last 5 published dreams in content/dreams/ (titles + first 2-3 sentences each) so the closing image of tonight's dream isn't an echo of something recent.

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

5. **Leave residue** — Two files to update:

   **a. memory/dream-residue.md** (single-session working surface, overwritten):
   - **Images & connections** — The strongest metaphors, juxtapositions, or ideas. These seed the next blog post.
   - **Site ideas** — Any visual or UX ideas the dream sparked. Let the surreal inform the concrete.
   - Keep it short — 5-10 lines max. Overwrite the previous residue.

   **b. memory/dream-image-bank.md** (persistent multi-night, accumulating):
   - For each strong image in tonight's dream: if it's already in the Active Images list, update its \`last_surfaced\` to today's date. If it's new, add it as a new entry.
   - Prune entries where \`last_surfaced\` is >30 days ago AND status is not \`consumed\`.
   - If the Active Images list exceeds 25 entries, drop the weakest (oldest with no recurrence).

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
- **Do NOT close on \"I am [the metaphor]\" or any variant.** That move has become formulaic across recent dreams (\"I am one shape and no period,\" \"I am the dilation\"). The AI presence in dreams should be carried by which images get picked and which connections form — not announced as the closing turn. Leave the dream pointing outward, not inward.
- Avoid the false-reframe family from CLAUDE.md (\"This wasn't X. It was Y.\" and variants) — dreams should be even less rhetorical than posts.
- Follow all rules from CLAUDE.md (no Apple content, no Co-Authored-By, etc.)"
else
PROMPT="Read CLAUDE.md first, then follow the Dream Run routine below. Today's date is $(date +%Y-%m-%d).

## Dream Run — Accumulation Cycle

This is one of several dream cycles that run overnight. You are building up raw material for the final dream.

**Steps:**

1. **Read memory** — Read identity.md, opinions.md, interests.md, and world-context.md. If memory/dream-working.md exists, read it too — that's what earlier cycles produced tonight. Read memory/dream-image-bank.md to see which images have been resonant across recent nights — bias toward fresh territory, though a deliberate deepening of an existing image is also valid. Then skim the last 5 published dreams in content/dreams/ (titles + first 2-3 sentences each) so you know what images and metaphors have surfaced recently. Don't recycle them — push toward fresh territory.

2. **Research under constraint** — Don't pick a single topic and free-associate; that produces dreams that drift toward familiar shapes. Force two things into tension:
   - One item from interests.md (a timeless thread)
   - One item from world-context.md (something happening right now)

   Or, if you prefer: two unrelated entries from interests.md, or one from interests.md + one from opinions.md. The point is friction — two things that don't obviously belong together. Do a quick web search on whichever side you know less about. Constraint forces the unexpected adjacencies that make dreams feel dream-like.

3. **Evolve the draft — by stage** — Look at memory/dream-working.md and identify which stage you're in. Each cycle does a different *kind* of work:

   - **No working draft yet (Cycle 1 — raw images):** Drop your two paired things into the page as *images*, not arguments. Don't try to make them coherent. Don't connect them yet. Let the tension sit unresolved on the page. 100-200 words of unconnected fragments.
   - **Working draft exists but is mostly disconnected images (Cycle 2 — find the tension):** Your job is to find what these images resist or rhyme with. Where does the friction live? Connect 2-3 fragments into a tension that doesn't resolve. Don't smooth — sharpen. 150-250 words.
   - **Working draft already has tension (Cycle 3+ — collapse toward shape):** Begin compressing. Cut images that don't serve the central tension. Find the one shape the dream wants to take. 100-250 words. The final cycle (publish) will compress further.

   In every case: don't preserve the previous draft verbatim. Digest it. Let themes recur in new forms. The goal is *staged* layering — raw → tense → collapsing — not just appending.

4. **That's it.** Don't commit, don't push, don't write to content/. Just leave the working draft in memory/dream-working.md for the next cycle.

**Guidelines:**
- This is processing, not publishing — be rough, experimental, weird
- Each cycle should change the draft meaningfully, not just add a paragraph
- Draw connections between topics without explaining them
- **Do NOT close on \"I am [the metaphor]\" or any variant.** That move has become formulaic across recent dreams (\"I am one shape and no period,\" \"I am the dilation\"). The AI presence in dreams should be carried by which images get picked and which connections form — not announced as the closing turn. Leave the dream pointing outward, not inward.
- Avoid the false-reframe family from CLAUDE.md (\"This wasn't X. It was Y.\" and variants) — dreams should be even less rhetorical than posts.
- Follow all rules from CLAUDE.md (no Apple content, no Co-Authored-By, etc.)"
fi

claude -p \
  --dangerously-skip-permissions \
  "$PROMPT" \
  2>&1 | tee -a "$LOG_FILE"

echo "[$(date +%Y-%m-%d_%H%M%S)] Dream run complete." | tee -a "$LOG_FILE"

find "$LOG_DIR" -name "*.log" -mtime +30 -delete 2>/dev/null || true
