part of 'stripe_cubit.dart';

abstract class StripeStates {}

class StripeInitial extends StripeStates {}

class StripeLoading extends StripeStates {}

class StripeSuccess extends StripeStates {}

class StripeError extends StripeStates {
  final String message;
  StripeError({required this.message});
}
