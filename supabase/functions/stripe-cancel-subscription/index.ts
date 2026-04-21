import { createClient } from 'npm:@supabase/supabase-js@2';

import { stripePost } from '../_shared/stripe.ts';

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

    const { data: subscription, error } = await supabase
      .from('subscriptions')
      .select('stripe_subscription_id')
      .eq('company_id', companyId)
      .maybeSingle();
    if (error) throw error;

    const stripeSubscriptionId = subscription?.stripe_subscription_id as
      | string
      | undefined;
    if (stripeSubscriptionId == null || stripeSubscriptionId.length == 0) {
      throw new Error('No active Stripe subscription');
    }

    await stripePost(
      `/subscriptions/${stripeSubscriptionId}`,
      new URLSearchParams({ cancel_at_period_end: 'true' }),
    );

    await supabase
      .from('subscriptions')
      .update({
        cancel_at_period_end: true,
        updated_at: new Date().toISOString(),
      })
      .eq('company_id', companyId);

    return new Response(JSON.stringify({ ok: true }), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});

