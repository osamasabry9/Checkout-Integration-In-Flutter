  import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../features/checkout/data/models/paypal_models/amount_model/amount_model.dart';
import '../../features/checkout/data/models/paypal_models/amount_model/details.dart';
import '../../features/checkout/data/models/paypal_models/item_list_model/item.dart';
import '../../features/checkout/data/models/paypal_models/item_list_model/item_list_model.dart';
import '../../features/checkout/presentation/views/thank_you_view.dart';
import '../utils/api_keys.dart';

void executePaypalPayment(BuildContext context,
      ({AmountModel amount, ItemListModel itemList}) transactionsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: AppKeys.clientIdPaypal,
        secretKey: AppKeys.secretKeyPaypal,
        transactions: [
          {
            "amount": transactionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionsData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return const ThankYouView();
            }),
          );
        },
        onError: (error) {
          log("onError: $error");
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("onError: $error"),
          ));
        },
        onCancel: () {
          log('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({
    AmountModel amount,
    ItemListModel itemList,
  }) getTransactionsData() {
    var amount = AmountModel(
      total: "100",
      currency: "USD",
      details: Details(
        subtotal: "100",
        shipping: "0",
        shippingDiscount: 0,
      ),
    );
    List<OrderItemModel> orderList = [
      OrderItemModel(
        name: "Apple",
        quantity: 4,
        price: "10",
        currency: "USD",
      ),
      OrderItemModel(
        name: "Pineapple",
        quantity: 5,
        price: "12",
        currency: "USD",
      ),
    ];
    var itemList = ItemListModel(items: orderList);

    return (
      amount: amount,
      itemList: itemList,
    );
  }
