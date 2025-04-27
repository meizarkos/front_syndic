import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';

import '../../../api_handler/union_artisans/get_detail_artisan.dart';
import '../../../api_handler/union_artisans/patch_account_status.dart';
import 'artisan_detail_validate.dart';

class ArtisanValidateRegister extends StatelessWidget {
  const ArtisanValidateRegister({
    super.key,
    required this.uuid,
  });

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return  ArtisanDetailValidate(
      fetchArtisan: getDetailArtisanFromUnion(uuid),
      patchArtisan:activateArtisan(uuid),
      text: AppText.validate,
    );
  }
}


class ArtisanBlock extends StatelessWidget {
  const ArtisanBlock({
    super.key,
    required this.uuid,
  });

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return  ArtisanDetailValidate(
      fetchArtisan: getDetailArtisanFromUnion(uuid),
      patchArtisan:deactivateArtisan(uuid),
      text: AppText.block,
    );
  }
}
