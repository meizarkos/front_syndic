import 'package:front_syndic/core_value.dart';

import '../request.dart';

Future<String> getEmail(String route) async {
  try{
    final res = await request(url: route, method: 'GET');
    final data = res.data;
    return data['email'];
  }
  catch(e){
    return '';
  }
}

Future<String> getEmailArtisan()async{
  return await getEmail('${APIValue.artisan}email_surf_artisan');
}