# Sustained Execution Roadmap

This roadmap keeps the project moving toward live revenue operation without waiting for ad hoc instructions.

## Current State

- Public GitHub Pages site is live.
- Payment, contact, and delivery UI exists.
- Payment, Formspree, and booking links are pending external setup.
- Public site has local and live QA scripts.
- Private kit stores operating templates, outreach materials, and delivery assets.

## Priority 1: Activate Revenue Links

Blocked by external setup:

- Diagnostic payment link
- Starter payment link
- Complete payment link
- Formspree endpoint
- Booking URL

When each value is available:

1. Add it to `siteConfig` in `index.html`.
2. Run `scripts/validate_site.sh`.
3. Commit and push.
4. Run `scripts/check_live_site.sh`.
5. Close the matching GitHub issue.

## Priority 2: Improve Conversion

Safe improvements while links are pending:

- Tighten package copy.
- Add one short FAQ section.
- Add a visible "configuration pending" admin note only where needed.
- Improve contact drawer microcopy.
- Add a small privacy note near the form.

## Priority 3: Build Trust

Add public-facing proof without exposing private operations:

- One anonymized sample workflow map.
- One example handoff checklist summary.
- One short "what happens after payment" FAQ.
- One safety note about human review for AI-generated replies.

## Priority 4: Operational Tracking

Keep GitHub as the maintenance hub:

- Track configuration tasks as issues.
- Track copy experiments as issues.
- Track QA failures as issues.
- Keep private prospect and revenue tracking out of the public repo.

## Priority 5: Delivery Readiness

In the private operating kit:

- Keep diagnostic templates current.
- Keep AI prompts aligned with public package promises.
- Keep test records updated.
- Keep handoff guide aligned with actual delivery process.

## Recurring Automation

A daily Codex automation is active for this project. It should:

- Inspect current repo state.
- Run available QA.
- Review open GitHub issues.
- Advance safe maintenance work.
- Preserve the public/private boundary.
- Summarize blockers and next priorities.
