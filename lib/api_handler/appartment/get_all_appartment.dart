import 'package:front_syndic/models/appartment/appartment.dart';

import '../../core_value.dart';
import '../request.dart';

Future<List<Apartment>?> getAllApartment()async{
  try{
    final response = await request(url: '${APIValue.union}get_all_appartment', method: "GET");
    final apartments = (response.data as List)
        .map((recordJson) => Apartment.fromJson(recordJson))
        .toList();
    return apartments;
  }catch(e){
    return null;
  }
}