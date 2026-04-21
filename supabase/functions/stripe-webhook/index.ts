import { createClient } from 'npm:@supabase/supabase-js@2';

type StripeEvent = {
  type: string;
  data: { object: Record<string, unknown> };
};

Deno.serve(async (req) => {
  try {
    const event = await req.json() as StripeEvent;
    const object = event.data.object;
    const metadata = (object['metadata'] as Record<string, string> | undefined) ??
      {};
    const companyId = metadata['company_id'];
    if (!companyId) {
      return new Response(JSON.stringify({ ok: true, skipped: 'no company_id' }), {
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const url = Deno.env.get('SUPABASE_URL') ?? '';
    const serviceRole = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '';
    if (!url || !serviceRole) {
      throw new Error('Missing Supabase env for function');
    }
    const supabase = createClient(url, serviceRole);

    if (
      event.type == 'customer.subscription.created' ||
      event.type == 'customer.subscription.updated'
    ) {
      const items = ((object['items'] as Record<string, unknown>)?.['data'] ??
        []) as Array<Record<string, unknown>>;
      const firstItem = items[0] as Record<string, unknown>;
      const price = firstItem['price'] as Record<string, unknown>;
      const subscriptionId = String(object['id']);
      const customerId = String(object['customer']);
      const priceId = String(price['id']);
      const status = String(object['status']);
      const periodEndUnix = Number(object['current_period_end']);
      const periodEnd = Number.isFinite(periodEndUnix)
        ? new Date(periodEndUnix * 1000).toISOString()
        : null;
      const plan = String((price['nickname'] ?? 'starter')).toLowerCase();
      const cancelAtPeriodEnd = Boolean(object['cancel_at_period_end']);

      await supabase.from('subscriptions').upsert({
        company_id: companyId,
        stripe_customer_id: customerId,
        stripe_subscription_id: subscriptionId,
        stripe_price_id: priceId,
        plan,
        status,
        current_period_end: periodEnd,
        cancel_at_period_end: cancelAtPeriodEnd,
        updated_at: new Date().toISOString(),
      });
    }

    if (event.type == 'customer.subscription.deleted') {
      await supabase
        .from('subscriptions')
        .update({
          status: 'canceled',
          cancel_at_period_end: true,
          updated_at: new Date().toISOString(),
        })
        .eq('company_id', companyId);
    }

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

