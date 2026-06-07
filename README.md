# AI Automation Service Site

Public GitHub Pages site for the AI Lead Follow-up Automation service.

This repository intentionally contains only the public-facing landing page and image asset.
It also includes SEO support files for GitHub Pages sharing and indexing:

- `robots.txt`
- `sitemap.xml`

Private operating materials, outreach templates, trackers, diagnostic templates, and delivery checklists are maintained in the private repository:

```text
kingsleyTom/ai-automation-service-kit
```

## Deploy

GitHub Pages serves `index.html` from the `main` branch root.

Fast path after editing:

```bash
scripts/deploy_site.sh --message "Update public site"
```

Preview without staging, committing, or pushing:

```bash
scripts/deploy_site.sh --dry-run
```

## Configure Commerce and Contact

Open `index.html` and find the `siteConfig` object near the top of the `<script>` block:

```js
const siteConfig = {
  paypalLinks: {
    diagnostic: "",
    starter: "",
    complete: ""
  },
  formspreeEndpoint: "",
  bookingUrl: "",
  contactFallbackUrl: "https://github.com/kingsleyTom"
};
```

Fill these values when ready:

- `paypalLinks.diagnostic`: PayPal link for the $99 diagnostic.
- `paypalLinks.starter`: PayPal link for the $199 Starter Build.
- `paypalLinks.complete`: PayPal link for the $499 Complete Workflow.
- `formspreeEndpoint`: Formspree endpoint such as `https://formspree.io/f/xxxxxxx`.
- `bookingUrl`: Calendly, TidyCal, or another scheduling link.
- `contactFallbackUrl`: fallback contact URL.

Until these links are configured, the live page shows safe "configuration needed" messaging instead of sending clients to broken payment or form URLs.

You can also configure the values with the helper script:

```bash
PAYPAL_DIAGNOSTIC_URL="https://www.paypal.com/..." \
PAYPAL_STARTER_URL="https://www.paypal.com/..." \
PAYPAL_COMPLETE_URL="https://www.paypal.com/..." \
FORMSPREE_ENDPOINT_URL="https://formspree.io/f/xxxxxxx" \
BOOKING_URL="https://calendly.com/..." \
CONTACT_FALLBACK_URL="https://github.com/kingsleyTom" \
node scripts/configure_site.mjs --write
```

Run it without `--write` first to preview the change.

For the full setup checklist, see:

- `CONFIGURATION.md`
- `OPERATIONS.md`
- `QA.md`
- `ROADMAP.md`

## Validate Locally

Before pushing site changes:

```bash
scripts/validate_site.sh
```

After GitHub Pages rebuilds:

```bash
scripts/check_live_site.sh
```

## Update Contact Link

The current fallback contact link points to:

```text
https://github.com/kingsleyTom
```

Replace it with a real email, booking link, or contact form when ready.

## Publish Updates

After editing, use the fast deploy script:

```bash
scripts/deploy_site.sh --message "Update commerce and contact configuration"
```

Manual fallback:

```bash
git status --short
git add index.html README.md CONFIGURATION.md OPERATIONS.md QA.md scripts/ .github/ISSUE_TEMPLATE/configuration_task.md
git commit -m "Update commerce and contact configuration"
git push
```

GitHub Pages will rebuild automatically from the `main` branch root.
