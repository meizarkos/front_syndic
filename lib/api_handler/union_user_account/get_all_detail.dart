import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/appartment/appartment.dart';

Future<Apartment?> getAllDetailForAccount(String? apartmentUuid)async{
  if(apartmentUuid == null){
    return null;
  }
  try{
    final response = await request(url: '${APIValue.union}get_all_detail/$apartmentUuid', method: "GET");
    final apartment = Apartment.fromJson(response.data);
    return apartment;
  }
  catch(e){
    return null;
  }
}