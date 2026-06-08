# Operations Runbook

Use this runbook to operate the public site and the private service kit.

## Repositories

Public website:

```text
https://github.com/kingsleyTom/ai-automation-service-site
```

Private operating kit:

```text
https://github.com/kingsleyTom/ai-automation-service-kit
```

## Public Website Responsibilities

The public site should contain only:

- Landing page
- Public service description
- Package cards
- Contact/intake form UI
- Payment links
- Booking link
- Public image assets

Do not put private operating assets in the public repository:

- Outreach CSVs
- Client delivery templates
- Internal pricing experiments
- Revenue tracker
- Diagnostic reports
- Client notes

## Private Kit Responsibilities

The private kit stores:

- Outreach plans
- Prospect CSVs
- Diagnostic templates
- Delivery checklists
- AI prompts
- Revenue tracker
- Client handoff materials

## Daily Operating Flow

1. Check new Formspree submissions.
2. Check payment provider activity.
3. Check booking calendar.
4. Create a delivery task in the private kit or GitHub issue.
5. Send the diagnostic intake questions.
6. Deliver within the promised window.
7. Update the revenue tracker.

## Weekly Maintenance

1. Review which package got clicks or inquiries.
2. Update package copy if customers are confused.
3. Archive inactive inquiries.
4. Add one insight or case study to the site.
5. Verify links still work.

## Configuration Checklist

- [ ] Diagnostic payment link configured.
- [ ] Starter payment link configured.
- [ ] Complete payment link configured.
- [ ] Formspree endpoint configured.
- [ ] Booking URL configured.
- [ ] Fallback contact URL updated.
- [ ] Test form submission received.
- [ ] Test booking redirect works.
- [ ] Test each payment redirect works.

## Incident Notes

If payments fail:

- Remove or blank the affected payment URL.
- The site will fall back to the pending configuration drawer.
- Update the link only after the payment provider is fixed.

If Formspree fails:

- Remove or blank `formspreeEndpoint`.
- The site will stop sending forms and show safe setup guidance.
- Keep the fallback contact URL active.
