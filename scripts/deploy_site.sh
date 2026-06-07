#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

commit_message="Update public site"
dry_run=0
skip_live_check=0
live_url="${LIVE_SITE_URL:-https://kingsleytom.github.io/ai-automation-service-site/}"

usage() {
  cat <<'EOF'
Deploy the public GitHub Pages site.

Usage:
  scripts/deploy_site.sh [--message "Commit message"] [--dry-run] [--skip-live-check]

Examples:
  scripts/deploy_site.sh --dry-run
  scripts/deploy_site.sh --message "Configure live payment links"
  LIVE_SITE_URL="https://example.com/" scripts/deploy_site.sh --skip-live-check

What it does:
  1. Runs scripts/validate_site.sh
  2. Stages public site files
  3. Commits if staged changes exist
  4. Pushes main to GitHub
  5. Waits briefly and runs scripts/check_live_site.sh
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --message)
      if [ "$#" -lt 2 ]; then
        echo "Missing value for --message"
        exit 1
      fi
      commit_message="$2"
      shift 2
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    --skip-live-check)
      skip_live_check=1
      shift
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

echo "Running local validation..."
scripts/validate_site.sh

echo "Current changed files:"
git status --short

if [ "$dry_run" -eq 1 ]; then
  echo "Dry run complete. No files were staged, committed, or pushed."
  exit 0
fi

git add -A -- \
  index.html \
  README.md \
  CONFIGURATION.md \
  OPERATIONS.md \
  QA.md \
  ROADMAP.md \
  robots.txt \
  sitemap.xml \
  assets \
  scripts

if git diff --cached --quiet; then
  echo "No staged changes to deploy."
  exit 0
fi

echo "Creating commit: $commit_message"
git commit -m "$commit_message"

echo "Pushing to GitHub..."
git push

if [ "$skip_live_check" -eq 1 ]; then
  echo "Skipped live check."
  exit 0
fi

echo "Waiting for GitHub Pages to rebuild..."
sleep 10

attempt=1
while [ "$attempt" -le 5 ]; do
  if scripts/check_live_site.sh "$live_url"; then
    echo "Deployment complete."
    exit 0
  fi

  echo "Live check attempt $attempt failed. Retrying..."
  attempt=$((attempt + 1))
  sleep 10
done

echo "Push succeeded, but live check did not pass yet. GitHub Pages may still be rebuilding."
exit 1
