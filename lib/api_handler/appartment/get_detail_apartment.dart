import 'package:front_syndic/models/appartment/appartment.dart';

import '../../core_value.dart';
import '../request.dart';

Future<Apartment?> getDetailApartment(String route)async{
  try{
    final response = await request(url: route, method: "GET");
    final apartment = Apartment.fromJson(response.data);
    return apartment;
  }catch(e){
    return null;
  }
}

Future<Apartment?> getDetailApartmentForUnion(String? apartmentUuid)async{
  if(apartmentUuid == null){
    return null;
  }
  return await getDetailApartment('${APIValue.union}get_appartment_detail/$apartmentUuid');
}