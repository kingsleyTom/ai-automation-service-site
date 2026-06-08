# QA Checklist

Use this checklist before and after changing payment, intake, booking, or public site copy.

## Local Checks

Run:

```bash
scripts/validate_site.sh
```

This checks:

- Required files exist.
- SEO files exist.
- Stale placeholder contact text is absent.
- Canonical, Open Graph, Twitter Card, and structured data tags exist.
- Commerce and contact configuration object exists.
- Payment buttons exist for all three packages.
- Intake form exists.
- Delivery and contact sections exist.
- Sample diagnostic workflow map exists.
- FAQ and privacy note exist.
- JavaScript syntax is valid.
- `robots.txt` points to `sitemap.xml`.
- `sitemap.xml` points to the live GitHub Pages URL.

## Configuration Checks

After adding real links:

- Diagnostic payment button redirects to the $99 checkout.
- Starter payment button redirects to the $199 checkout.
- Complete payment button redirects to the $499 checkout.
- Intake form sends a test message to Formspree.
- Booking buttons redirect to the scheduler.
- Fallback contact link works.

## Live Checks

After pushing:

```bash
scripts/check_live_site.sh
```

This confirms the GitHub Pages page is reachable and contains the expected production sections.

## Fast Deployment

Use the deployment script when you want validation, commit, push, and live check in one flow:

```bash
scripts/deploy_site.sh --message "Update public site"
```

Use dry-run mode first if you want to confirm the local validation result without staging anything:

```bash
scripts/deploy_site.sh --dry-run
```

## Manual Browser Checks

Desktop:

- Navigation links scroll to the correct sections.
- Hero slide dots change the headline.
- Product tabs update the feature panel.
- Payment buttons open pending-configuration messaging when links are blank.
- Contact form preserves input and shows setup guidance when Formspree is blank.
- Contact drawer opens and closes.
- Sample workflow map is readable and does not expose private client details.
- FAQ questions expand and collapse.
- Partner carousel moves.

Mobile:

- Mobile nav opens.
- Package cards stack cleanly.
- Form fields stack in one column.
- No text overlaps buttons or cards.
- Floating contact rail is hidden.

## Release Notes

When a release changes commerce or contact behavior, add a short commit message that names the changed integration, for example:

```text
Configure diagnostic payment link
```
