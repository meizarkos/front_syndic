import 'package:flutter/material.dart';
import 'package:front_syndic/views/estimate/estimate_detail/estimate_detail.dart';

import '../../../api_handler/estimate/change_status_estimate.dart';
import '../../../models/to_screen/see_conv_arg.dart';
import '../../../widget/handle_status/text_based_on_user.dart';

class EstimateDetailCouncil extends StatelessWidget {
  const EstimateDetailCouncil({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return EstimateDetail(
      fetchData: fetchData,
      uuid: uuid,
      role: RoleBasedText.council,
      patchStatus: (String? id)async{
        if(uuid == null) return;
        await patchEstimateCouncil(id);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/estimate/council/detail',
          arguments: SeeConvArg(uuid: uuid!, futureToFetchData: fetchData)
        );
      },
    );
  }
}
