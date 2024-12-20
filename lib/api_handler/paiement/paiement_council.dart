import 'dart:convert';

import '../../core_value.dart';
import '../request_with_body.dart';

Future<String?> createPaymentCouncil(String amount, String currency) async {
  try {
    var body = jsonEncode({
      'amount': amount,
      'currency': currency,
    });
    final response = await requestWithBody(url: '${APIValue.unionCouncil}paiement', method: "POST", body: body);
    return response.data['stripeAnswer'];

  }catch(e){
    print(e);
    return null;
  }
}