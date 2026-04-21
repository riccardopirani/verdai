alter table subscriptions
  add column if not exists stripe_price_id text,
  add column if not exists updated_at timestamptz default now();

create unique index if not exists subscriptions_company_unique
  on subscriptions (company_id);

