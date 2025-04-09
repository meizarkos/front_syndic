import 'package:flutter/material.dart';
import '../../../api_handler/appartment/get_detail_apartment.dart';
import 'detail_user.dart';

class DetailUserUnionSide extends StatelessWidget {
  const DetailUserUnionSide({
    super.key,
    required this.apartmentUuid,
  });

  final String? apartmentUuid;

  @override
  Widget build(BuildContext context) {
    return UserDetail(
      fetchData: getDetailApartmentForUnion(apartmentUuid),
      apartmentUuid: apartmentUuid,
    );
  }
}
