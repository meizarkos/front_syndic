import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';

import '../../../models/estimate/estimate.dart';
import '../../../widget/header/app_bar_back_button.dart';

class RecapEstimate extends StatefulWidget {
  const RecapEstimate({
    super.key,
    required this.estimate,
  });

  final Estimate estimate;

  @override
  State<RecapEstimate> createState() => _RecapEstimateState();
}

class _RecapEstimateState extends State<RecapEstimate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              Text(
                'Récapitulatif',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'Prix : ${widget.estimate.price}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'Commentaire : ${widget.estimate.commentary}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          )
      ),
    );
  }
}
