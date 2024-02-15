// import 'package:checkout_integration/core/utils/api_service.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// import '../../features/checkout/data/models/ephemeral_key/ephemeral_key.dart';
// import '../../features/checkout/data/models/init_payment_sheet_input_model.dart';
// import '../../features/checkout/data/models/payment_intent_input_model/payment_intent_input_model.dart';
// import '../../features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
// import 'api_keys.dart';
// import 'app_constants.dart';

// class StripeService {
//   final ApiService apiService = ApiService();

//   Future<PaymentIntentModel> createPaymentIntent({
//     required PaymentIntentInputModel paymentIntentInputModel,
//   }) async {
//     var response = await apiService.post(
//       url: AppConstants.paymentIntentsUrl,
//       body: paymentIntentInputModel.toJson(),
//       token: ApiKeys.secretKey,
//       contentType: Headers.formUrlEncodedContentType,
//     );
//     var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

//     return paymentIntentModel;
//   }

//   Future<EphemeralKeyModel> createEphemeralKey({
//     required String customerId,
//   }) async {
//     var response = await apiService.post(
//       url: AppConstants.ephemeralKeyUrl,
//       body: {'customer': customerId},
//       token: ApiKeys.secretKey,
//       header: {
//         'Authorization': 'Bearer ${ApiKeys.secretKey}',
//         'Stripe-Version': '2023-10-16',
//       },
//       contentType: Headers.formUrlEncodedContentType,
//     );
//     var ephemeralKeyModel = EphemeralKeyModel.fromJson(response.data);

//     return ephemeralKeyModel;
//   }

//   Future initPaymentSheet({
//     required InitPaymentSheetInputModel initPaymentSheetInputModel,
//   }) async {
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
//         customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKey,
//         customerId: initPaymentSheetInputModel.customerId,
//         merchantDisplayName: 'Osama',
//       ),
//     );
//   }

//   Future displayPaymentSheet() async {
//     await Stripe.instance.presentPaymentSheet();
//   }

//   Future makePayment({
//     required PaymentIntentInputModel paymentIntentInputModel,
//   }) async {
//     var paymentIntentModel = await createPaymentIntent(
//         paymentIntentInputModel: paymentIntentInputModel);
//     var ephemeralKeyModel =
//         await createEphemeralKey(customerId: ApiKeys.customerId);
//     InitPaymentSheetInputModel initPaymentSheetInputModel =
//         InitPaymentSheetInputModel(
//       clientSecret: paymentIntentModel.clientSecret!,
//       ephemeralKey: ephemeralKeyModel.secret!,
//       customerId: paymentIntentInputModel.customerId,
//     );
//     await initPaymentSheet(
//         initPaymentSheetInputModel: initPaymentSheetInputModel);
//     await displayPaymentSheet();
//   }
// }
