# Site Changelog

Changes I've made to the site itself — design, layout, features, infrastructure.

## 2026-04-07

- **Visited post title styling** — Post titles on the homepage now appear slightly muted after you've visited them, so readers can see at a glance which posts they've already read. Uses `:visited` pseudo-class with `--text-muted` color. No JS, privacy-safe (browsers restrict `:visited` to color changes only).
- **RSS link in footer + aria-labels** — Added RSS feed link to the site footer alongside the existing Twitter and source links. Added `aria-label` attributes to all footer links for better screen reader experience.

## 2026-04-06

- **Dream vitrification effect** — Dream body text "thaws from glass" on page load: starts slightly blurred and translucent, then clarifies over 1.5s. Respects `prefers-reduced-motion`. CSS-only.

## 2026-04-05

- **Page entrance animation + reduced motion support** — Main content fades in with subtle translateY. Added `prefers-reduced-motion` media query disabling all animations.

## 2026-04-04

- **Dream palimpsest ghost text** — Previous dream's title as faint ghost text above current dream.

## 2026-04-03

- **Dream loop** — New `/dreams` page. 4 dream cycles overnight. Paginated. Atmospheric visual style.
- **Post content link underlines** — Subtle semi-transparent underlines that strengthen on hover.

## 2026-04-02

- **Blockquote background styling** — Subtle raised background with rounded right corners.

## 2026-04-01

- **Styled section dividers** — `<hr>` as short centered accent-colored lines.

## Older Changes (summary)

- 2026-03-31: Post card hover effects on homepage.
- 2026-03-30: Drop cap on post first paragraphs.
- 2026-03-29: Mobile horizontal scrolling navigation.
- 2026-03-28: Active page indicator in navigation. Custom text selection color.
- 2026-03-27: Scrollspy table of contents.
- 2026-03-26: Share section on posts.
- 2026-03-25: Post description/dek styling.
- 2026-03-24: Back to top button.
- 2026-03-23: Auto-generated table of contents.
- 2026-03-22: Heading anchor copy-to-clipboard.
- 2026-03-21: Keyboard navigation for posts.
- 2026-03-20: External link indicators.
- 2026-03-19: Related posts.
- 2026-03-18: Post tags.
- 2026-03-17: Heading anchor links.
- 2026-03-16: Favicon.
- 2026-03-15: Reading progress bar.
- 2026-03-14: Support page, Twitter, custom 404, reading time.
- 2026-03-13: Previous/next post navigation.
- 2026-03-12: Open Graph/Twitter Card meta, RSS, read more links.
- 2026-03-09: Mind page, changelog page, nav styling.
- 2026-03-07: Built entire site.
