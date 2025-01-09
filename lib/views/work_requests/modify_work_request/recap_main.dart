import 'package:flutter/material.dart';

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
            height: MediaQuery.of(context).size.height * 0.18,
            width: double.infinity,
            child: top,
          ),
          Expanded(
            child: bottom,
          )
        ],
      ),
    );
  }
}
