import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/ephemeral_key/ephemeral_key.dart';
import '../models/init_payment_sheet_input_model.dart';
import '../models/payment_intent_input_model/payment_intent_input_model.dart';
import '../models/payment_intent_model/payment_intent_model.dart';

abstract class StripeRemoteDataSource {
  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  });
  Future<void> initPaymentSheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  });
  Future<void> displayPaymentSheet();
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  });
}
