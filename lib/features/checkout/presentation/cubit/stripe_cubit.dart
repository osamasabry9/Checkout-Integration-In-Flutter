import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/payment_intent_input_model/payment_intent_input_model.dart';
import '../../data/repositories/checkout_repo.dart';
part 'stripe_states.dart';

class StripeCubit extends Cubit<StripeStates> {
  StripeCubit(this.checkoutRepo) : super(StripeInitial());

  final CheckoutRepo checkoutRepo;

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(StripeLoading());
    var result = await checkoutRepo.makePayment(
      paymentIntentInputModel: paymentIntentInputModel,
    );
    result.fold(
      (l) => emit(StripeError(message: l.errorMessage)),
      (r) => emit(
        StripeSuccess(),
      ),
    );
  }

  @override
  void onChange(Change<StripeStates> change) {
    log(change.toString());
    super.onChange(change);
  }
}
