# Commerce and Contact Configuration

This site is a static GitHub Pages site. It does not process payment card data or store form submissions directly.

All live integrations are controlled by the `siteConfig` object inside `index.html`.

## Current Configuration Status

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

Until values are filled:

- Payment buttons show a safe setup message.
- The intake form does not send data.
- Booking buttons open the contact drawer.

## Payment Links

Create one checkout link for each package. Stripe Payment Links is the preferred default, but PayPal, Square, Lemon Squeezy, Gumroad, or another checkout provider can be used if it gives a direct URL.

- `$99 Diagnostic`
- `$199 Starter Build`
- `$499 Complete Workflow`

Then paste each URL into:

```js
paymentLinks: {
  diagnostic: "DIAGNOSTIC_PAYMENT_URL",
  starter: "STARTER_PAYMENT_URL",
  complete: "COMPLETE_PAYMENT_URL"
}
```

Acceptance check:

- Click each payment button.
- It should redirect to the correct checkout page.
- No payment button should open the "Payment link pending configuration" drawer after configuration.

## Helper Script

You can update the configuration with environment variables instead of editing JavaScript by hand.

Dry run:

```bash
DIAGNOSTIC_PAYMENT_URL="https://buy.stripe.com/..." \
STARTER_PAYMENT_URL="https://buy.stripe.com/..." \
COMPLETE_PAYMENT_URL="https://buy.stripe.com/..." \
FORMSPREE_ENDPOINT_URL="https://formspree.io/f/xxxxxxx" \
BOOKING_URL="https://calendly.com/..." \
CONTACT_FALLBACK_URL="https://github.com/kingsleyTom" \
node scripts/configure_site.mjs
```

Write changes:

```bash
DIAGNOSTIC_PAYMENT_URL="https://buy.stripe.com/..." \
STARTER_PAYMENT_URL="https://buy.stripe.com/..." \
COMPLETE_PAYMENT_URL="https://buy.stripe.com/..." \
FORMSPREE_ENDPOINT_URL="https://formspree.io/f/xxxxxxx" \
BOOKING_URL="https://calendly.com/..." \
CONTACT_FALLBACK_URL="https://github.com/kingsleyTom" \
node scripts/configure_site.mjs --write
```

The script only accepts `http://` or `https://` values.
Legacy `PAYPAL_DIAGNOSTIC_URL`, `PAYPAL_STARTER_URL`, and `PAYPAL_COMPLETE_URL` are still accepted.

Stripe test links are accepted for QA, but they are not live payment links. The page displays a test payment mode notice when any checkout URL contains `buy.stripe.com/test_`.

## Formspree Intake Form

Create a Formspree form and copy the endpoint, usually shaped like:

```text
https://formspree.io/f/xxxxxxx
```

Paste it into:

```js
formspreeEndpoint: "https://formspree.io/f/xxxxxxx"
```

Acceptance check:

- Submit a test inquiry.
- Confirm Formspree receives the message.
- Confirm the notification email arrives.
- Confirm the on-page toast says the intake was submitted.

## Booking Link

Create a booking page with Calendly, TidyCal, SavvyCal, or another scheduler.

Paste it into:

```js
bookingUrl: "BOOKING_URL"
```

Acceptance check:

- Click "Start diagnostic", "Book diagnostic", and "Book a time".
- Each should redirect to the booking page.

## Fallback Contact

The fallback currently points to:

```text
https://github.com/kingsleyTom
```

Replace it with a more direct contact page when ready:

```js
contactFallbackUrl: "https://your-contact-url.example"
```

## Publish Changes

From the public site repo:

```bash
git status --short
git add index.html CONFIGURATION.md README.md
git commit -m "Configure live commerce and contact links"
git push
```

GitHub Pages will rebuild automatically.
