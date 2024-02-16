import '../../../../core/functions/paypal_functions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/stripe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/api_keys.dart';
import '../../data/models/payment_intent_input_model/payment_intent_input_model.dart';
import '../views/thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  final int indexActive;
  const CustomButtonBlocConsumer({
    super.key,
    required this.indexActive,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripeCubit, StripeStates>(
      listener: (context, state) {
        if (state is StripeSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return const ThankYouView();
            }),
          );
        }
        if (state is StripeError) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            if (indexActive == 0) {
              final paymentIntentInputModel = PaymentIntentInputModel(
                amount: "100",
                currency: "USD",
                customerId: AppKeys.customerId,
              );
              BlocProvider.of<StripeCubit>(context).makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);
            } else {
              var transactionsData = getTransactionsData();
              executePaypalPayment(context, transactionsData);
            }
          },
          isLoading: state is StripeLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}
