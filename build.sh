#!/usr/bin/env bash
# Rebuild the static assets from source. Run after editing src/app.jsx.
# Requires Node. Installs build tools locally (node_modules, gitignored).
set -euo pipefail
cd "$(dirname "$0")"

echo "→ installing build tools (first run only)…"
npm install --no-audit --no-fund --silent \
  @babel/core@7 @babel/cli@7 @babel/preset-react@7 tailwindcss@3.4.17

echo "→ transpiling src/app.jsx → assets/app.js (JSX → plain JS, no runtime Babel)…"
npx babel src/app.jsx --presets @babel/preset-react -o assets/app.js

echo "→ building assets/tailwind.css (only the utilities actually used)…"
cat > .tw.config.js <<'CFG'
module.exports = { content: ['./index.html', './assets/app.js'], theme: { extend: {} }, plugins: [] }
CFG
printf '@tailwind base;\n@tailwind components;\n@tailwind utilities;\n' > .tw.input.css
npx tailwindcss -c .tw.config.js -i .tw.input.css -o assets/tailwind.css --minify
rm -f .tw.config.js .tw.input.css

echo "✓ done. assets/app.js and assets/tailwind.css regenerated."
echo "  React is vendored in vendor/ (pinned 18.3.1) — no CDN at page load."
