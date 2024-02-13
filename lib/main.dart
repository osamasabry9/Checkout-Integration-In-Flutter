import 'package:checkout_integration/features/checkout/presentation/views/thank_you_view.dart';
import 'package:flutter/material.dart';

import 'features/checkout/presentation/views/my_cart_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Checkout Integration',
      debugShowCheckedModeBanner: false,
      home: ThankYouView(),
    );
  }
}
