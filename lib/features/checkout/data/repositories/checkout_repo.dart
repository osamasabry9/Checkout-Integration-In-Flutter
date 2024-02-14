import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/payment_intent_input_model/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
