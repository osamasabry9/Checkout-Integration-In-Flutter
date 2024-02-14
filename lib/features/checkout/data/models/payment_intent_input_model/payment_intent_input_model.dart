class PaymentIntentInputModel {
  final String amount;
  final String currency;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': currency,
      };

  factory PaymentIntentInputModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentInputModel(
      amount: json['amount'] as String,
      currency: json['currency'] as String,
    );
  }
}
