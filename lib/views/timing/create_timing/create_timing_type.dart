import 'package:flutter/material.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/timing/create_timing/create_timing.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/timing/post_timing.dart';

class CreateTimingArtisan extends StatelessWidget {
  const CreateTimingArtisan({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return CreateTiming(
        futureCreateMeeting: postTimingFromConvArtisan,
        convUuid: convUuid,
        routeToConv : () {
          if(convUuid == null) return;
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            '/artisan/see_conv',
            arguments: convUuid!,
          );
        }
    );
  }
}

class CreateTimingUnion extends StatelessWidget {
  const CreateTimingUnion ({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return CreateTiming(
        futureCreateMeeting: postTimingFromConvUnion,
        convUuid: convUuid,
        routeToConv : () {
          if(convUuid == null) return;
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            'union/specific_conv',
            arguments: convUuid!,
          );
        }
    );
  }
}

class CreateTimingCouncil extends StatelessWidget {
  const CreateTimingCouncil ({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return CreateTiming(
        futureCreateMeeting: postTimingFromConvCouncil,
        convUuid: convUuid,
        routeToConv : () {
          if(convUuid == null) return;
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            '/council/see_conv',
            arguments: convUuid!,
          );
        }
    );
  }
}