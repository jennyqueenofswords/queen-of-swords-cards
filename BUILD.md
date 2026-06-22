# Build notes

This page renders React **without any runtime CDN dependency**. Everything it
needs is committed to the repo, so an upstream CDN change can never blank it
out again (which is what happened: an unpinned Babel auto-upgraded to v8 and
broke in-browser transpilation).

## How it's wired
- `src/app.jsx` — the source (JSX). **Edit cards here.**
- `assets/app.js` — `src/app.jsx` transpiled to plain JS at build time. The
  browser loads this directly; no Babel runs at page load.
- `assets/tailwind.css` — Tailwind compiled to a static stylesheet containing
  only the utility classes the page uses.
- `vendor/` — React + ReactDOM 18.3.1, pinned, served locally.
- `index.html` — references the above. No `<script type="text/babel">`, no CDNs.

## To change the cards (or any UI)
1. Edit `src/app.jsx`
2. Run `./build.sh`
3. Commit `src/app.jsx`, `assets/app.js`, `assets/tailwind.css`
4. Push — GitHub Pages redeploys in ~1 minute.
