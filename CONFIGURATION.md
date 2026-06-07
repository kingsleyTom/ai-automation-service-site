# Commerce and Contact Configuration

This site is a static GitHub Pages site. It does not process payment card data or store form submissions directly.

All live integrations are controlled by the `siteConfig` object inside `index.html`.

## Current Configuration Status

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

Until values are filled:

- PayPal buttons show a safe setup message.
- The intake form does not send data.
- Booking buttons open the contact drawer.

## PayPal Links

Create one PayPal payment link for each package:

- `$99 Diagnostic`
- `$199 Starter Build`
- `$499 Complete Workflow`

Then paste each URL into:

```js
paypalLinks: {
  diagnostic: "PAYPAL_DIAGNOSTIC_URL",
  starter: "PAYPAL_STARTER_URL",
  complete: "PAYPAL_COMPLETE_URL"
}
```

Acceptance check:

- Click each payment button.
- It should redirect to the correct PayPal checkout page.
- No payment button should open the "Payment link pending configuration" drawer after configuration.

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
