import 'stripe_remote_data_source.dart';
import '../models/ephemeral_key/ephemeral_key.dart';
import '../models/init_payment_sheet_input_model.dart';
import '../models/payment_intent_input_model/payment_intent_input_model.dart';
import '../models/payment_intent_model/payment_intent_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/api_keys.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_constants.dart';

class StripeRemoteDataSourceImpl implements StripeRemoteDataSource {
  final ApiService apiService = ApiService();

  @override
  Future<PaymentIntentModel> createPaymentIntent({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var response = await apiService.post(
      url: AppConstants.paymentIntentsUrl,
      body: paymentIntentInputModel.toJson(),
      token: ApiKeys.secretKey,
      contentType: Headers.formUrlEncodedContentType,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

    return paymentIntentModel;
  }

  @override
  Future<EphemeralKeyModel> createEphemeralKey({
    required String customerId,
  }) async {
    var response = await apiService.post(
      url: AppConstants.ephemeralKeyUrl,
      body: {'customer': customerId},
      token: ApiKeys.secretKey,
      header: {
        'Authorization': 'Bearer ${ApiKeys.secretKey}',
        'Stripe-Version': '2023-10-16',
      },
      contentType: Headers.formUrlEncodedContentType,
    );
    var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);

    return ephemeralKeyModel;
  }

  @override
  Future initPaymentSheet({
    required InitPaymentSheetInputModel initPaymentSheetInputModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
        customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKey,
        customerId: initPaymentSheetInputModel.customerId,
        merchantDisplayName: 'Osama',
      ),
    );
  }

  @override
  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    try {
      var paymentIntentModel = await createPaymentIntent(
          paymentIntentInputModel: paymentIntentInputModel);
      var ephemeralKeyModel =
          await createEphemeralKey(customerId: ApiKeys.customerId);
      InitPaymentSheetInputModel initPaymentSheetInputModel =
          InitPaymentSheetInputModel(
        clientSecret: paymentIntentModel.clientSecret!,
        ephemeralKey: ephemeralKeyModel.secret!,
        customerId: paymentIntentInputModel.customerId,
      );
      await initPaymentSheet(
          initPaymentSheetInputModel: initPaymentSheetInputModel);
      await displayPaymentSheet();
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
