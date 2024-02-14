import 'package:checkout_integration/core/utils/stripe_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/payment_intent_input_model/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      return right(null);
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
