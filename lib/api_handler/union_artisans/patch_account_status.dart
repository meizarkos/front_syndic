import '../../core_value.dart';
import '../request.dart';

Future<void> patchArtisanAccounStatus(String route) async {
  try{
    final response = await request(url: route, method: "PATCH");
    return;
  } catch(e) {
    print('Error fetching artisans: $e');
    return;
  }
}

Future<void> activateArtisan(String? uuid)async{
  if (uuid == null) {
    return;
  }
  return await patchArtisanAccounStatus('${APIValue.union}acitvate_artisan/$uuid');
}

Future<void> deactivateArtisan(String? uuid)async{
  if (uuid == null) {
    return;
  }
  return await patchArtisanAccounStatus('${APIValue.union}deacitvate_artisan/$uuid');
}