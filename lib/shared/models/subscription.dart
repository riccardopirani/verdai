class Subscription {
  const Subscription({
    required this.id,
    required this.companyId,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    required this.plan,
    this.priceId,
    this.status = 'active',
    this.currentPeriodEnd,
    this.cancelAtPeriodEnd = false,
    this.createdAt,
  });

  final String id;
  final String companyId;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final String plan;
  final String? priceId;
  final String status;
  final DateTime? currentPeriodEnd;
  final bool cancelAtPeriodEnd;
  final DateTime? createdAt;

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      stripeCustomerId: json['stripe_customer_id'] as String?,
      stripeSubscriptionId: json['stripe_subscription_id'] as String?,
      plan: json['plan'] as String,
      priceId: json['stripe_price_id'] as String?,
      status: json['status'] as String? ?? 'active',
      currentPeriodEnd: json['current_period_end'] != null
          ? DateTime.tryParse(json['current_period_end'] as String)
          : null,
      cancelAtPeriodEnd: json['cancel_at_period_end'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }
}
