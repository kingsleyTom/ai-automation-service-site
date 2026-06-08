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
  paymentLinks: {
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

- `paymentLinks.diagnostic`: checkout link for the $99 diagnostic.
- `paymentLinks.starter`: checkout link for the $199 Starter Build.
- `paymentLinks.complete`: checkout link for the $499 Complete Workflow.
- `formspreeEndpoint`: Formspree endpoint such as `https://formspree.io/f/xxxxxxx`.
- `bookingUrl`: Calendly, TidyCal, or another scheduling link.
- `contactFallbackUrl`: fallback contact URL.

Until these links are configured, the live page shows safe "configuration needed" messaging instead of sending clients to broken payment or form URLs.

You can also configure the values with the helper script:

```bash
DIAGNOSTIC_PAYMENT_URL="https://buy.stripe.com/..." \
STARTER_PAYMENT_URL="https://buy.stripe.com/..." \
COMPLETE_PAYMENT_URL="https://buy.stripe.com/..." \
FORMSPREE_ENDPOINT_URL="https://formspree.io/f/xxxxxxx" \
BOOKING_URL="https://calendly.com/..." \
CONTACT_FALLBACK_URL="https://github.com/kingsleyTom" \
node scripts/configure_site.mjs --write
```

Stripe, PayPal, Square, Lemon Squeezy, Gumroad, or any provider that gives a direct checkout URL can be used. Legacy `PAYPAL_*` environment variables are still accepted by the helper script.

Run it without `--write` first to preview the change.

If Stripe test links are configured, the public page shows a test payment mode notice. Replace all `https://buy.stripe.com/test_...` URLs with live checkout URLs before accepting real customers.

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
