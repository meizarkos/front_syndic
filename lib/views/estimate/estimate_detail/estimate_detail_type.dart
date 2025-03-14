import 'package:flutter/material.dart';
import 'package:front_syndic/views/estimate/estimate_detail/estimate_detail.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/estimate/change_status_estimate.dart';
import '../../../api_handler/timing_estimate/get_timing_estimate.dart';
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
      patchStatus: (String? id,VoidCallback changeText)async{
        if(uuid == null) return;
        await patchEstimateCouncil(id,changeText);
      },
      refuseEstimate: (String? id,VoidCallback changeText)async{
        if(uuid == null) return;
        await refuseEstimateCouncil(id,changeText);
      },
      goToConv: (String? id){
        if(id == null) return;
        Navigator.pushNamed(context, '/council/see_conv',
            arguments: SeeConvArg(uuid: id, futureToFetchData: fetchSpecificConvCouncilFromEstimate)
        );
      },
      goToTiming: (String? id){
        if(id == null) return;
        Navigator.pushNamed(context, '/council/timing_estimate',
            arguments: SeeConvArg(uuid: id, futureToFetchData: fetchTimingEstimateCouncil)
        );
      },
    );
  }
}

class EstimateDetailUnion extends StatelessWidget {
  const EstimateDetailUnion({
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
      role: RoleBasedText.union,
      patchStatus: (String? id,VoidCallback changeText)async{
        if(uuid == null) return;
        await patchEstimateUnion(id,changeText);
      },
      refuseEstimate: (String? id,VoidCallback changeText)async{
        if(uuid == null) return;
        await refuseEstimateUnion(id,changeText);
      },
      goToConv: (String? id){
        if(id == null) return;
        Navigator.pushNamed(context, 'union/specific_conv',
            arguments: SeeConvArg(uuid: id, futureToFetchData: fetchSpecificConvUnionFromEstimate)
        );
      },
      goToTiming: (String? id){
        if(id == null) return;
        Navigator.pushNamed(context, '/union/timing_estimate',
            arguments: SeeConvArg(uuid: id, futureToFetchData: fetchTimingEstimateUnion)
        );
      },
    );
  }
}
