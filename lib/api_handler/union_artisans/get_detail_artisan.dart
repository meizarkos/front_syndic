import 'package:front_syndic/core_value.dart';

import '../../models/artisan/artisan.dart';
import '../request.dart';

Future<Artisan?> getDetailArtisanFromUnion(String? artisanUuid) async {
  if (artisanUuid == null) {
    return null;
  }
  try{
    final response = await request(url: '${APIValue.union}union_validate_detail_artisan/$artisanUuid', method: "GET");
    final artisan = Artisan.fromJson(response.data);

    return artisan;
  } catch(e) {
    return null;
  }
}