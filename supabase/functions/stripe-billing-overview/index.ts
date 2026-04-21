import { createClient } from 'npm:@supabase/supabase-js@2';

import { PLAN_SEEDS, upsertPlans } from '../_shared/stripe.ts';

Deno.serve(async (req) => {
  try {
    const { companyId } = await req.json();
    if (!companyId) throw new Error('companyId required');

    const url = Deno.env.get('SUPABASE_URL') ?? '';
    const serviceRole = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
    if (!url || !serviceRole) {
      throw new Error('Missing Supabase env for function');
    }
    const supabase = createClient(url, serviceRole);

    const priceByPlan = await upsertPlans();
    const { data: subscription, error } = await supabase
      .from('subscriptions')
      .select()
      .eq('company_id', companyId)
      .maybeSingle();
    if (error) throw error;

    const plans = PLAN_SEEDS.map((p) => ({
      key: p.key,
      name: p.productName,
      unitAmount: (p.amount / 100).toFixed(2),
      interval: p.interval,
      description: p.description,
      stripePriceId: priceByPlan[p.key],
    }));

    return new Response(
      JSON.stringify({
        subscription,
        plans,
      }),
      { headers: { 'Content-Type': 'application/json' } },
    );
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});

