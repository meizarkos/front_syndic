import 'package:flutter/material.dart';
import 'package:front_syndic/views/union_side/create_council/confirm/confirm_creation.dart';

import '../../../../api_handler/council/post_council.dart';
import '../../../../api_handler/credential.dart';
import '../../../../models/council/createCouncil.dart';

class ConfirmCreationFromUnion extends StatelessWidget {
  const ConfirmCreationFromUnion({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ConfirmCreationCouncil(
      createCouncil: createCouncil,
      onRegister: () async {
        await postCouncilUnion(createCouncil);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/union_main',
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}

class ConfirmCouncilRegister extends StatelessWidget {
  const ConfirmCouncilRegister({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ConfirmCreationCouncil(
      createCouncil: createCouncil,
      onRegister: () async {
        final token = await registerCouncil(createCouncil);
        Credential.instance.token = 'Bearer $token';
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/council_main',
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
