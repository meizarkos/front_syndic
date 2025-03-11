import 'dart:convert';

import '../../core_value.dart';
import '../request_with_body.dart';


Future<String?> createPayement(int amount, String currency,String url)async{
  try {
    var body = jsonEncode({
      'amount': amount,
      'currency': currency,
    });
    final response = await requestWithBody(url: url, method: "POST", body: body);
    return response.data['stripeAnswer'];

  }catch(e){
    print(e);
    return null;
  }
}


Future<String?> createPaymentCouncil(int amount, String currency) async {
  return await createPayement(amount, currency, '${APIValue.unionCouncil}paiement');
}

Future<String?> createPaymentUnion(int amount, String currency) async {
  return await createPayement(amount, currency, '${APIValue.union}paiement');
}