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

Future<String> getEmailCouncil()async{
  return await getEmail('${APIValue.unionCouncil}email_surf');
}

Future<String> getEmailUnion()async{
  return await getEmail('${APIValue.union}email_surf_union');
}

Future<String> getEmailUser()async{
  return await getEmail('${APIValue.user}email_surf_user');
}