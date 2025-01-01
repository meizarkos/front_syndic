import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/artisan/artisan.dart';

Future<Artisan?> getArtisan() async {
  try{
    final res = await request(url: '${APIValue.artisan}artisan', method: "GET");
    final artisan = Artisan.fromJson(res.data);
    return artisan;
  }catch(e){
    return null;
  }
}