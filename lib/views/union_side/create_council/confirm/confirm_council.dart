import 'package:flutter/material.dart';

import '../../../../models/council/createCouncil.dart';
import 'confirm.dart';

class UnionConfirmCouncilCreation extends StatelessWidget {
  const UnionConfirmCouncilCreation({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ConfirmCreationCouncilUnion(createCouncil: createCouncil);
  }
}


class CouncilConfirmRegister extends StatelessWidget {
  const CouncilConfirmRegister({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ConfirmCreationCouncilUnion(
        createCouncil: createCouncil,

    );
  }
}
