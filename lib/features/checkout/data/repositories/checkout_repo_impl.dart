import '../datasources/stripe_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../datasources/stripe_remote_data_source_impl.dart';
import '../models/payment_intent_input_model/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpl implements CheckoutRepo {
  final StripeRemoteDataSource stripeRemoteDataSource =
      StripeRemoteDataSourceImpl();
  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async =>
      stripeRemoteDataSource.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
}
