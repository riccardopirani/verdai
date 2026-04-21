-- Verdant initial schema (run in Supabase SQL editor or via CLI)

CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  vat_number TEXT,
  sector TEXT,
  size TEXT,
  country TEXT DEFAULT 'IT',
  website TEXT,
  logo_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  stripe_customer_id TEXT UNIQUE,
  stripe_subscription_id TEXT UNIQUE,
  plan TEXT NOT NULL,
  status TEXT DEFAULT 'active',
  current_period_end TIMESTAMPTZ,
  cancel_at_period_end BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE emission_records (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  year INTEGER NOT NULL,
  month INTEGER,
  scope INTEGER NOT NULL,
  category TEXT NOT NULL,
  value_kwh NUMERIC,
  value_liters NUMERIC,
  value_km NUMERIC,
  co2_kg NUMERIC NOT NULL,
  source TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE esg_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  report_year INTEGER NOT NULL,
  standard TEXT NOT NULL,
  status TEXT DEFAULT 'draft',
  esg_score NUMERIC(5,2),
  environmental_score NUMERIC(5,2),
  social_score NUMERIC(5,2),
  governance_score NUMERIC(5,2),
  total_co2_tons NUMERIC(10,3),
  pdf_url TEXT,
  data JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  published_at TIMESTAMPTZ
);

CREATE TABLE esg_metrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  year INTEGER NOT NULL,
  category TEXT NOT NULL,
  metric_key TEXT NOT NULL,
  metric_value NUMERIC,
  metric_text TEXT,
  unit TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE compliance_alerts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  standard TEXT NOT NULL,
  severity TEXT DEFAULT 'info',
  title TEXT NOT NULL,
  description TEXT,
  deadline TIMESTAMPTZ,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE emission_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE esg_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE esg_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE compliance_alerts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users see own company" ON companies
  FOR ALL USING (auth.uid() = user_id);

CREATE POLICY "Users manage own emissions" ON emission_records
  FOR ALL USING (company_id IN (SELECT id FROM companies WHERE user_id = auth.uid()));

CREATE POLICY "Users manage own reports" ON esg_reports
  FOR ALL USING (company_id IN (SELECT id FROM companies WHERE user_id = auth.uid()));

CREATE POLICY "Users see own metrics" ON esg_metrics
  FOR ALL USING (company_id IN (SELECT id FROM companies WHERE user_id = auth.uid()));

CREATE POLICY "Users see own subscription" ON subscriptions
  FOR ALL USING (company_id IN (SELECT id FROM companies WHERE user_id = auth.uid()));

CREATE POLICY "Users see own alerts" ON compliance_alerts
  FOR ALL USING (company_id IN (SELECT id FROM companies WHERE user_id = auth.uid()));
