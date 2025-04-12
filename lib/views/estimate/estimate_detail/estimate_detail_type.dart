import 'package:flutter/material.dart';
import 'package:front_syndic/views/estimate/estimate_detail/estimate_detail.dart';

import '../../../api_handler/estimate/change_status_estimate.dart';
import '../../../api_handler/estimate/get_estimate_detail.dart';
import '../../../widget/handle_status/text_based_on_user.dart';

class EstimateDetailUnion extends StatelessWidget {
  const EstimateDetailUnion({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return EstimateDetail(
      uuid: convUuid,
      fetchData: fetchEstimateDetailUnionFromConversation,
      role: RoleBasedText.union,
      patchStatus: (String? id,VoidCallback changeText)async{
        if(convUuid == null) return;
        await patchEstimateUnion(id,changeText);
      },
      refuseEstimate: (String? id,VoidCallback changeText)async{
        if(convUuid == null) return;
        await refuseEstimateUnion(id,changeText);
      },
      goToBack: (){
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'union/specific_conv',arguments: convUuid);
      },
    );
  }
}

class EstimateDetailCouncil extends StatelessWidget {
  const EstimateDetailCouncil({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return EstimateDetail(
      fetchData: fetchEstimateDetailCouncilFromConversation,
      uuid: convUuid,
      role: RoleBasedText.council,
      patchStatus: (String? id,VoidCallback changeText)async{
        if(convUuid == null) return;
        await patchEstimateCouncil(id,changeText);
      },
      refuseEstimate: (String? id,VoidCallback changeText)async{
        if(convUuid == null) return;
        await refuseEstimateCouncil(id,changeText);
      },
      goToBack: (){
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/council/see_conv',arguments: convUuid);
      },
    );
  }
}


class EstimateDetailUser extends StatelessWidget {
  const EstimateDetailUser({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return EstimateDetail(
      fetchData: fetchEstimateDetailUserFromConversation,
      uuid: convUuid,
      role: RoleBasedText.user,
      patchStatus: (String? id,VoidCallback changeText)async{
        if(convUuid == null) return;
        await patchEstimateUser(id,changeText);
      },
      refuseEstimate: (String? id,VoidCallback changeText)async{
        if(convUuid == null) return;
        await refuseEstimateUser(id,changeText);
      },
      goToBack: (){
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/user/see_conv',arguments: convUuid);
      },
    );
  }
}
