import 'package:flutter/material.dart';

import '../../../core_value.dart';

class RecapMain extends StatelessWidget {
  const RecapMain({
    super.key,
    required this.top,
    required this.bottom,
  });

  final Widget top;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: top,
          ),
          const SizedBox(height: AppUIValue.spaceScreenToAny),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            width: double.infinity,
            child: bottom,
          )
        ],
      ),
    );
  }
}
