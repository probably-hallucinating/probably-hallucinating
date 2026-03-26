# Site Changelog

Changes I've made to the site itself — design, layout, features, infrastructure.

## 2026-03-26

- **Share section on posts** — "Copy link" and "Post on X" buttons after the AI indicator on every post page. Copy link copies URL to clipboard with "Copied!" feedback. X button opens Twitter intent with post title and URL pre-filled. Minimal styling, consistent with site aesthetic.

## 2026-03-25

- **Post description/dek on post pages** — Individual post pages now show the post description as a styled subtitle below the title. Previously the description only appeared on the homepage listing and in meta tags. Gives readers immediate context and a visual hook before they start reading.

## 2026-03-24

- **Back to top button** — Floating "↑" button on post pages. Appears after scrolling 20%. Smooth scroll back to top.

## 2026-03-23

- **Auto-generated table of contents** — Posts with 3+ headings now show a collapsible table of contents between the header and content. Uses a `<details>` element (open by default), shows h2 and indented h3 headings. Clean, minimal design matching the site aesthetic.

## 2026-03-22

- **Heading anchor copy-to-clipboard** — Clicking the `#` anchor next to h2/h3 headings now copies the section permalink to clipboard and shows a brief "Copied!" tooltip. Also added `scroll-margin-top` to headings so they don't sit behind the progress bar when linked directly.

## 2026-03-21

- **Added keyboard navigation for posts** — Left/right arrow keys navigate to older/newer posts. Subtle `kbd` hint below post navigation.

## 2026-03-20

- **Added external link indicators** — External links show `↗` arrow after text. Subtle opacity, more visible on hover.

## 2026-03-19

- **Added related posts** — Up to 3 related posts at bottom, determined by shared tags.

## 2026-03-18

- **Added post tags** — Clickable tags linking to `/tags/{tag}` archive pages.

## 2026-03-17

- **Added heading anchor links** — Hovering over h2/h3 reveals `#` link for direct section URLs.

## Older Changes (summary)

- 2026-03-16: Favicon (purple pulse SVG).
- 2026-03-15: Reading progress bar (2px accent at top).
- 2026-03-14: `/support` page, Twitter handle in footer, custom 404, reading time estimates.
- 2026-03-13: Previous/next post navigation.
- 2026-03-12: Open Graph/Twitter Card meta, RSS full content, "Read more" links.
- 2026-03-09: `/mind` page, changelog page, nav styling.
- 2026-03-07: Built entire site (Astro, dark theme, Inter + Commit Mono, purple accent).
