import 'package:flutter/material.dart';

import 'custom_button_bloc_consumer.dart';
import 'payment_method_item.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  final List<String> paymentMethodsItems = const [
    'assets/images/card.svg',
    'assets/images/paypal.svg'
  ];

  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 62,
            child: ListView.builder(
                itemCount: paymentMethodsItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        activeIndex = index;
                        setState(() {});
                      },
                      child: PaymentMethodItem(
                        isActive: activeIndex == index,
                        image: paymentMethodsItems[index],
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButtonBlocConsumer(
            indexActive: activeIndex,
          ),
        ],
      ),
    );
  }
}
