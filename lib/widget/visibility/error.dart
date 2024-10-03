import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';

class ErrorVisibility extends StatelessWidget {
  const ErrorVisibility({
    super.key,
    required this.errorVisibility,
    required this.errorText
  });

  final bool errorVisibility;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: errorVisibility,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            errorText,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.mainErrorColor,
            ),
          ),
        ),
      ),
    );
  }
}
