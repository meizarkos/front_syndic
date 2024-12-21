import 'package:flutter/material.dart';

import '../../../../models/council/createCouncil.dart';
import 'contact_info_council.dart';

class UnionContactInfoCouncil extends StatelessWidget {
  const UnionContactInfoCouncil({
    super.key,
    required this.createCouncil
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ContactInfoCouncil(
      createCouncil: createCouncil,
      route: '/union/create_council/adress',
    );
  }
}

class CreateContactInfoCouncil extends StatelessWidget {
  const CreateContactInfoCouncil({
    super.key,
    required this.createCouncil
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ContactInfoCouncil(
      createCouncil: createCouncil,
      route: 'council/adress',
    );
  }
}
