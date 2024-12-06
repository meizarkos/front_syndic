import 'package:flutter/material.dart';

import '../../../api_handler/co_owner/get_main_data_co_owner.dart';
import 'co_owner_detail.dart';

class CoOwnerDetailCouncil extends StatelessWidget {
  const CoOwnerDetailCouncil({super.key});

  @override
  Widget build(BuildContext context) {
    return CoOwnerDetail(
      fetchData: getCoOwnerMainDataFromCouncil,
      uuid: null,
    );
  }
}

class CoOwnerDetailUnion extends StatelessWidget {
  const CoOwnerDetailUnion({
    super.key,
    required this.uuid,
  });

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return CoOwnerDetail(
      fetchData: getCoOwnerMainDataFromUnion,
      uuid: uuid,
    );
  }
}
