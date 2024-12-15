import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/string_handler/handle_string.dart';

Row rowOfTextAndIcon(String path, String toPrint, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SvgPicture.asset(
        path,
        width: 40.0,
        height: 40.0,
      ),
      const SizedBox(width: 20),
      Text(
        toPrint,
        style: Theme.of(context).textTheme.labelMedium,
        textAlign: TextAlign.center,
        maxLines: 6,
      ),
    ],
  );
}