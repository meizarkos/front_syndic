import '../../core_value.dart';
import '../request.dart';

Future<void> deleteEstimate(String route) async {
  try{
    final response = await request(url: route, method: "DELETE");
    return;
  } catch(e) {
    return;
  }
}

Future<void> deleteEstimateArtisan(String? uuid) async {
  if(uuid == null) return;
  return await deleteEstimate('${APIValue.artisan}estimate_detail_artisan/$uuid');
}