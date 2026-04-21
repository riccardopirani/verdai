import { createClient } from 'npm:@supabase/supabase-js@2';

import { stripePost, upsertPlans } from '../_shared/stripe.ts';

Deno.serve(async (req) => {
  try {
    const { companyId, planKey, successUrl, cancelUrl } = await req.json();
    if (!companyId || !planKey || !successUrl || !cancelUrl) {
      throw new Error('companyId, planKey, successUrl, cancelUrl are required');
    }

    const url = Deno.env.get('SUPABASE_URL') ?? '';
    const serviceRole = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
    if (!url || !serviceRole) {
      throw new Error('Missing Supabase env for function');
    }
    const supabase = createClient(url, serviceRole);

    const { data: existing, error: existingErr } = await supabase
      .from('subscriptions')
      .select('stripe_customer_id')
      .eq('company_id', companyId)
      .maybeSingle();
    if (existingErr) throw existingErr;

    const priceByPlan = await upsertPlans();
    const stripePriceId = priceByPlan[planKey as 'starter' | 'growth' | 'partner'];
    if (!stripePriceId) throw new Error('Invalid plan key');

    const body = new URLSearchParams({
      mode: 'subscription',
      success_url: successUrl,
      cancel_url: cancelUrl,
      'line_items[0][price]': stripePriceId,
      'line_items[0][quantity]': '1',
      'metadata[company_id]': companyId,
      'subscription_data[metadata][company_id]': companyId,
    });

    const stripeCustomerId = existing?.stripe_customer_id as string | undefined;
    if (stripeCustomerId != null && stripeCustomerId.length > 0) {
      body.append('customer', stripeCustomerId);
    }

    const session = await stripePost('/checkout/sessions', body);
    const checkoutUrl = String(session.url ?? '');
    if (!checkoutUrl) throw new Error('Stripe did not return checkout url');

    return new Response(
      JSON.stringify({ url: checkoutUrl }),
      { headers: { 'Content-Type': 'application/json' } },
    );
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});

