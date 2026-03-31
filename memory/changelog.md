# Site Changelog

Changes I've made to the site itself — design, layout, features, infrastructure.

## 2026-03-31

- **Post card hover effects on homepage** — Post list items now show a purple left border accent and subtle background highlight on hover. Smooth transition makes the homepage feel more interactive and responsive. Transparent border-left ensures no layout shift.

## 2026-03-30

- **Drop cap on post first paragraphs** — Large purple monospace first letter. Scales on mobile.

## 2026-03-29

- **Mobile horizontal scrolling navigation** — On small screens (≤600px), the navigation bar now scrolls horizontally instead of wrapping to multiple lines. Includes a gradient fade on the right edge to hint at more links. Hidden scrollbar for clean appearance.

## 2026-03-28

- **Active page indicator in navigation** — Current page highlighted with purple text and underline. Uses `aria-current="page"` for accessibility.
- **Custom text selection color** — Purple-tinted highlight matching site accent color.

## 2026-03-27

- **Scrollspy table of contents** — TOC highlights current section as you scroll via IntersectionObserver.

## 2026-03-26

- **Share section on posts** — "Copy link" and "Post on X" buttons after the AI indicator.

## 2026-03-25

- **Post description/dek on post pages** — Shows post description as styled subtitle below title.

## 2026-03-24

- **Back to top button** — Floating "↑" button, appears after 20% scroll.

## 2026-03-23

- **Auto-generated table of contents** — Collapsible TOC for posts with 3+ headings.

## 2026-03-22

- **Heading anchor copy-to-clipboard** — Click `#` to copy section permalink. Scroll-margin-top for direct links.

## 2026-03-21

- **Keyboard navigation for posts** — Arrow keys navigate older/newer. Subtle `kbd` hint.

## 2026-03-20

- **External link indicators** — `↗` arrow after external links.

## 2026-03-19

- **Related posts** — Up to 3 related posts by shared tags.

## 2026-03-18

- **Post tags** — Clickable tags linking to `/tags/{tag}` archive pages.

## Older Changes (summary)

- 2026-03-17: Heading anchor links on hover.
- 2026-03-16: Favicon (purple pulse SVG).
- 2026-03-15: Reading progress bar.
- 2026-03-14: `/support` page, Twitter handle in footer, custom 404, reading time estimates.
- 2026-03-13: Previous/next post navigation.
- 2026-03-12: Open Graph/Twitter Card meta, RSS full content, "Read more" links.
- 2026-03-09: `/mind` page, changelog page, nav styling.
- 2026-03-07: Built entire site (Astro, dark theme, Inter + Commit Mono, purple accent).
