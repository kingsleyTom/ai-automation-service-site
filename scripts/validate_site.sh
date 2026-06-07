#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

test -f index.html
test -f README.md
test -f CONFIGURATION.md
test -f OPERATIONS.md
test -f robots.txt
test -f sitemap.xml
test -f assets/automation-hero.png

if grep -E "YOUR NAME|your\.email@example\.com|mailto:" index.html >/dev/null; then
  echo "Found stale placeholder contact text."
  exit 1
fi

required_patterns=(
  "const siteConfig ="
  "<link rel=\"canonical\" href=\"https://kingsleytom.github.io/ai-automation-service-site/\">"
  "property=\"og:title\""
  "name=\"twitter:card\""
  "application/ld+json"
  "paypalLinks:"
  "diagnostic: \"\""
  "starter: \"\""
  "complete: \"\""
  "formspreeEndpoint: \"\""
  "bookingUrl: \"\""
  "Choose a paid workflow path"
  "Delivery flow after payment"
  "Sample diagnostic output"
  "Example: new lead to review-ready follow-up"
  "Online contact and intake"
  "Common questions before starting"
  "Privacy note:"
  "Payment link pending configuration"
  "id=\"intakeForm\""
  "class=\"faq-question\""
  "id=\"sample\""
  "data-pay=\"diagnostic\""
  "data-pay=\"starter\""
  "data-pay=\"complete\""
)

for pattern in "${required_patterns[@]}"; do
  if ! grep -F "$pattern" index.html >/dev/null; then
    echo "Missing required pattern: $pattern"
    exit 1
  fi
done

grep -F "Sitemap: https://kingsleytom.github.io/ai-automation-service-site/sitemap.xml" robots.txt >/dev/null
grep -F "<loc>https://kingsleytom.github.io/ai-automation-service-site/</loc>" sitemap.xml >/dev/null

tmp_js="${TMPDIR:-/tmp}/leadflow-site-script.js"
perl -0ne 'while(/<script>(.*?)<\/script>/sg){print $1}' index.html > "$tmp_js"
node --check "$tmp_js" >/dev/null

echo "Site validation passed."
