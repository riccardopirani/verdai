# Stripe billing setup (code-first)

These functions auto-create/update the 3 recurring plans in Stripe:

- `starter` -> Verdai Starter (EUR 29 / month)
- `growth` -> Verdai Growth (EUR 79 / month)
- `partner` -> Verdai Partner (EUR 199 / month)

No manual product/price creation is required in Stripe dashboard.

## Required secrets

Set these in Supabase project secrets:

- `STRIPE_SECRET_KEY`
- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`

## Deploy

1. Run DB migrations (`001_initial_schema.sql`, then `002_stripe_billing.sql`).
2. Deploy functions:
   - `stripe-billing-overview`
   - `stripe-create-checkout-session`
   - `stripe-create-customer-portal`
   - `stripe-cancel-subscription`
   - `stripe-webhook`
3. In Stripe webhook settings, point events to `stripe-webhook` endpoint:
   - `customer.subscription.created`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`

