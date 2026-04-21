import { createClient } from 'npm:@supabase/supabase-js@2';

import { stripePost } from '../_shared/stripe.ts';

Deno.serve(async (req) => {
  try {
    const { companyId, returnUrl } = await req.json();
    if (!companyId || !returnUrl) {
      throw new Error('companyId and returnUrl are required');
    }

    const url = Deno.env.get('SUPABASE_URL') ?? '';
    const serviceRole = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
    if (!url || !serviceRole) {
      throw new Error('Missing Supabase env for function');
    }
    const supabase = createClient(url, serviceRole);

    const { data: subscription, error } = await supabase
      .from('subscriptions')
      .select('stripe_customer_id')
      .eq('company_id', companyId)
      .maybeSingle();
    if (error) throw error;
    const customerId = subscription?.stripe_customer_id as string | undefined;
    if (customerId == null || customerId.length == 0) {
      throw new Error('No Stripe customer for this company');
    }

    const session = await stripePost(
      '/billing_portal/sessions',
      new URLSearchParams({
        customer: customerId,
        return_url: returnUrl,
      }),
    );
    return new Response(JSON.stringify({ url: session.url }), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (e) {
    return new Response(JSON.stringify({ error: String(e) }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});

