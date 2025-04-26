import 'package:front_syndic/models/artisan/artisan.dart';

import '../../core_value.dart';
import '../request.dart';

Future<List<Artisan>?> getAllArtisan(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final artisans = (response.data as List)
        .map((artisan) => Artisan.fromJson(artisan))
        .toList();
    return artisans;
  } catch(e) {
    print('Error fetching artisans: $e');
    return null;
  }
}

Future<List<Artisan>?> getAllArtisanInactiveUnion() async {
  return await getAllArtisan('${APIValue.union}all_artisans_inactive');
}

Future<List<Artisan>?> getAllArtisanActiveUnion() async {
  return await getAllArtisan('${APIValue.union}all_artisans_active');
}