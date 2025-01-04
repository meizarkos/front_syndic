import 'package:flutter/material.dart';

import '../../../../api_handler/co_owner/get_co_owner.dart';
import '../../../../api_handler/co_owner/patch_co_owner.dart';
import 'modify_council.dart';

class ModifyCouncilForCouncil extends StatelessWidget {
  const ModifyCouncilForCouncil({super.key});

  @override
  Widget build(BuildContext context) {
    return ModifyCouncil(
      fetchData: getCoOwnerFromCouncil,
      patchData: patchCoOwnerFromCouncil,
    );
  }
}

class ModifyCouncilForUnion extends StatelessWidget {
  const ModifyCouncilForUnion({
    super.key,
    required this.councilId,
  });

  final String? councilId;

  @override
  Widget build(BuildContext context) {
    return ModifyCouncil(
      fetchData: getCoOwnerFromUnion,
      patchData: patchCoOwnerFromUnion,
      councilId: councilId,
    );
  }
}
