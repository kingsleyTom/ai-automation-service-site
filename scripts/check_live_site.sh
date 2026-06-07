#!/usr/bin/env bash
set -euo pipefail

site_url="${1:-https://kingsleytom.github.io/ai-automation-service-site/}"

html="$(curl -fsSL "$site_url")"

required_patterns=(
  "LeadFlow Cyber"
  "Choose a paid workflow path"
  "Delivery flow after payment"
  "Online contact and intake"
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

echo "Live site check passed: $site_url"
