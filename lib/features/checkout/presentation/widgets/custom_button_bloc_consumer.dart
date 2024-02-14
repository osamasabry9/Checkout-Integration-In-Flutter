import 'package:checkout_integration/core/widgets/custom_button.dart';
import 'package:checkout_integration/features/checkout/presentation/cubit/stripe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/payment_intent_input_model/payment_intent_input_model.dart';
import '../views/thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
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
            final paymentIntentInputModel = PaymentIntentInputModel(
              amount: "100",
              currency: "USD",
            );
            BlocProvider.of<StripeCubit>(context)
                .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          isLoading: state is StripeLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}
