import '../../core_value.dart';
import '../../models/estimate/estimate.dart';
import '../request.dart';

Future<Estimate?> fetchEstimateDetail(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final record = Estimate.fromJson(response.data);
    return record;
  } catch(e) {
    return null;
  }
}

Future<Estimate?> fetchEstimateDetailArtisan(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.artisan}estimate_detail_artisan/$id');
}

Future<Estimate?> fetchEstimateDetailArtisanFromEstimate(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.artisan}estimate_detail_artisan_from_conversation/$id');
}