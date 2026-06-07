# QA Checklist

Use this checklist before and after changing payment, intake, booking, or public site copy.

## Local Checks

Run:

```bash
scripts/validate_site.sh
```

This checks:

- Required files exist.
- Stale placeholder contact text is absent.
- Commerce and contact configuration object exists.
- PayPal buttons exist for all three packages.
- Intake form exists.
- Delivery and contact sections exist.
- JavaScript syntax is valid.

## Configuration Checks

After adding real links:

- Diagnostic PayPal button redirects to the $99 checkout.
- Starter PayPal button redirects to the $199 checkout.
- Complete PayPal button redirects to the $499 checkout.
- Intake form sends a test message to Formspree.
- Booking buttons redirect to the scheduler.
- Fallback contact link works.

## Live Checks

After pushing:

```bash
scripts/check_live_site.sh
```

This confirms the GitHub Pages page is reachable and contains the expected production sections.

## Manual Browser Checks

Desktop:

- Navigation links scroll to the correct sections.
- Hero slide dots change the headline.
- Product tabs update the feature panel.
- PayPal buttons open pending-configuration messaging when links are blank.
- Contact form preserves input and shows setup guidance when Formspree is blank.
- Contact drawer opens and closes.
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
Configure PayPal diagnostic link
```
