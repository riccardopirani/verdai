export type PlanKey = 'starter' | 'growth' | 'partner';

export type PlanSeed = {
  key: PlanKey;
  productName: string;
  amount: number;
  currency: string;
  interval: 'month' | 'year';
  description: string;
};

export const PLAN_SEEDS: PlanSeed[] = [
  {
    key: 'starter',
    productName: 'Verdai Starter',
    amount: 2900,
    currency: 'eur',
    interval: 'month',
    description: 'Per micro e piccole aziende che iniziano il percorso ESG.',
  },
  {
    key: 'growth',
    productName: 'Verdai Growth',
    amount: 7900,
    currency: 'eur',
    interval: 'month',
    description: 'Per PMI in crescita con workflow ESG e report avanzati.',
  },
  {
    key: 'partner',
    productName: 'Verdai Partner',
    amount: 19900,
    currency: 'eur',
    interval: 'month',
    description: 'Per gruppi e consulenti con esigenze multi-azienda.',
  },
];

export const STRIPE_API = 'https://api.stripe.com/v1';

export function getStripeSecret(): string {
  const secret = Deno.env.get('STRIPE_SECRET_KEY') ?? '';
  if (!secret) {
    throw new Error('Missing STRIPE_SECRET_KEY');
  }
  return secret;
}

export async function stripePost(
  path: string,
  body: URLSearchParams,
): Promise<Record<string, unknown>> {
  const response = await fetch(`${STRIPE_API}${path}`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${getStripeSecret()}`,
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body,
  });
  const json = await response.json();
  if (!response.ok) {
    throw new Error(`Stripe error ${response.status}: ${JSON.stringify(json)}`);
  }
  return json as Record<string, unknown>;
}

export async function stripeGet(path: string): Promise<Record<string, unknown>> {
  const response = await fetch(`${STRIPE_API}${path}`, {
    method: 'GET',
    headers: {
      Authorization: `Bearer ${getStripeSecret()}`,
    },
  });
  const json = await response.json();
  if (!response.ok) {
    throw new Error(`Stripe error ${response.status}: ${JSON.stringify(json)}`);
  }
  return json as Record<string, unknown>;
}

export async function upsertPlans(): Promise<Record<PlanKey, string>> {
  const out: Partial<Record<PlanKey, string>> = {};

  for (const plan of PLAN_SEEDS) {
    const products = await stripeGet(
      `/products/search?query=${encodeURIComponent(`active:'true' AND metadata['plan_key']:'${plan.key}'`)}`,
    );
    const productList = (products.data as Array<Record<string, unknown>>?) ?? [];
    const product = productList[0] ??
        await stripePost(
          '/products',
          new URLSearchParams({
            name: plan.productName,
            description: plan.description,
            'metadata[plan_key]': plan.key,
          }),
        );

    const productId = String(product.id);
    const prices = await stripeGet(
      `/prices/search?query=${encodeURIComponent(`active:'true' AND product:'${productId}'`)}`,
    );
    const priceList = (prices.data as Array<Record<string, unknown>>?) ?? [];
    const existing = priceList.find(
      (p) =>
        Number(p.unit_amount) == plan.amount &&
        String(p.currency) == plan.currency &&
        String((p.recurring as Record<string, unknown>).interval) == plan.interval,
    );
    const price = existing ??
        await stripePost(
          '/prices',
          new URLSearchParams({
            product: productId,
            unit_amount: String(plan.amount),
            currency: plan.currency,
            'recurring[interval]': plan.interval,
            nickname: plan.key,
          }),
        );
    out[plan.key] = String(price.id);
  }

  return out as Record<PlanKey, string>;
}

