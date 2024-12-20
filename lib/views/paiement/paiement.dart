import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../api_handler/paiement/paiement_council.dart';

class Paiement extends StatefulWidget {
  const Paiement({super.key});

  @override
  State<Paiement> createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: elevatedButtonAndTextColor(
        AppColors.mainBackgroundColor,
        'Payer',
        context,
        (){makePayment();},
        AppColors.mainTextColor,
      ),
    );
  }

  Future<String?> createPaymentIntent(String amount, String currency) async {
    try {
      return await createPaymentCouncil(amount, currency);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> makePayment() async {
    try {
      var paymentIntent = await createPaymentIntent('100', 'USD'); //API call

      if(paymentIntent == null){
        return;
      }

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!,
              style: ThemeMode.light,
              merchantDisplayName: 'Ikay')
      );

      //STEP 3: Display Payment sheet
      await displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    }
    catch (e) {
      print('$e');
    }
  }
}
