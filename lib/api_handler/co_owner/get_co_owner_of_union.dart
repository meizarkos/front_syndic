import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import '../request.dart';

Future<List<CoOwner>?> fetchAllCoOwnersFromUnion() async {
  try{
    final response = await request(url: '${APIValue.baseUnion}get_co_owners', method: "GET");
    final records = (response.data as List)
        .map((recordJson) => CoOwner.fromJson(recordJson))
        .toList();
    return records;
  } on DioException catch(e) {
    return null;
  }
}