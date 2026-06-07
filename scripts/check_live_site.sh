#!/usr/bin/env bash
set -euo pipefail

site_url="${1:-https://kingsleytom.github.io/ai-automation-service-site/}"

html="$(curl -fsSL "$site_url")"

required_patterns=(
  "LeadFlow Cyber"
  "<link rel=\"canonical\" href=\"https://kingsleytom.github.io/ai-automation-service-site/\">"
  "property=\"og:title\""
  "name=\"twitter:card\""
  "application/ld+json"
  "Choose a paid workflow path"
  "Delivery flow after payment"
  "Sample diagnostic output"
  "Example: new lead to review-ready follow-up"
  "Online contact and intake"
  "Common questions before starting"
  "Privacy note:"
  "const siteConfig ="
  "paypalLinks:"
  "formspreeEndpoint"
  "bookingUrl"
)

for pattern in "${required_patterns[@]}"; do
  if ! printf "%s" "$html" | grep -F "$pattern" >/dev/null; then
    echo "Live site missing required pattern: $pattern"
    exit 1
  fi
done

curl -fsSI "$site_url" >/dev/null
curl -fsSL "${site_url%/}/robots.txt" | grep -F "Sitemap: https://kingsleytom.github.io/ai-automation-service-site/sitemap.xml" >/dev/null
curl -fsSL "${site_url%/}/sitemap.xml" | grep -F "<loc>https://kingsleytom.github.io/ai-automation-service-site/</loc>" >/dev/null

echo "Live site check passed: $site_url"
