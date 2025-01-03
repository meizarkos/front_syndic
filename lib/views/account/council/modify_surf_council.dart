import 'package:flutter/material.dart';

import '../../../api_handler/surf/get_email.dart';
import '../../../api_handler/surf/patch_email.dart';
import '../modify_surf.dart';

class ModifySurfCouncil extends StatelessWidget {
  const ModifySurfCouncil({super.key});

  @override
  Widget build(BuildContext context) {
    return ModifySurf(
      fetchSurf: getEmailCouncil,
      patchSurf: patchSurfCouncil,
    );
  }
}