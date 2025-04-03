import 'package:flutter/material.dart';

import '../../../../models/council/createCouncil.dart';
import 'chose_name.dart';

class UnionChoseNameCouncil extends StatelessWidget {
  const UnionChoseNameCouncil({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ChoseName(
        createCouncil: createCouncil,
        route : '/union/create_council/contact_info',
    );
  }
}

class CouncilChoseName extends StatelessWidget {
  const CouncilChoseName({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ChoseName(
        createCouncil: createCouncil,
        route: '/council/info_contact',
    );
  }
}
