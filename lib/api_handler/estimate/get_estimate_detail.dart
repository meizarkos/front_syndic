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

Future<Estimate?> fetchEstimateDetailArtisanFromConversation(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.artisan}estimate_detail_artisan_from_conversation/$id');
}

Future<Estimate?> fetchEstimateDetailArtisanFromTiming(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.artisan}estimate_detail_artisan_from_timing/$id');
}

Future<Estimate?> fetchEstimateDetailCouncil(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.unionCouncil}estimate_detail_council/$id');
}


Future<Estimate?> fetchEstimateDetailCouncilFromTiming(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.unionCouncil}estimate_detail_council_from_timing/$id');
}

Future<Estimate?> fetchEstimateDetailCouncilFromTimingEstimate(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.unionCouncil}estimate_detail_council_from_timing_estimate/$id');
}

Future<Estimate?> fetchEstimateDetailCouncilFromConversation(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.unionCouncil}estimate_detail_council_from_conversation/$id');
}

Future<Estimate?> fetchEstimateDetailUnion(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.union}estimate_detail_union/$id');
}

Future<Estimate?> fetchEstimateDetailUnionFromConversation(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.union}estimate_detail_union_from_conv/$id');
}

Future<Estimate?> fetchEstimateDetailUnionFromTiming(String? id) async {
  if(id == null) return null;
  return await fetchEstimateDetail('${APIValue.union}estimate_detail_union_from_timing/$id');
}