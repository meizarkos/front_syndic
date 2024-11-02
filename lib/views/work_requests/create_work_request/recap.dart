import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/work_request/work_request_post.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../color.dart';
import '../../../models/work_request/create_work_request.dart';
import '../../../text/fr.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import 'chose_time/cell_time.dart';

const double spaceTitleDesc = 20;
const double spaceCate = 40;

class RecapWorkRequest extends StatefulWidget {
  const RecapWorkRequest({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  State<RecapWorkRequest> createState() => _RecapWorkRequestState();
}

class _RecapWorkRequestState extends State<RecapWorkRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title : AppText.createWorkRequestRecap),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              Text(
                stringNullOrDefaultValue(widget.createWorkRequest.workRequest.title, AppText.apiNoResult),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: spaceCate),
              Text(
                AppText.description,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              Text(
                stringNullOrDefaultValue(widget.createWorkRequest.workRequest.description, AppText.apiNoResult),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: spaceCate),
              Text(
                AppText.category,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              Text(
                stringNullOrDefaultValue(widget.createWorkRequest.workRequest.category, AppText.apiNoResult),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: spaceCate),
              Text(
                AppText.yourDisposition,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              if (widget.createWorkRequest.workRequest.timings != null &&
                  widget.createWorkRequest.workRequest.timings!.isNotEmpty)
                ...widget.createWorkRequest.workRequest.timings!.map((date) {
                  if(date.date == null || date.time == null){
                    return const SizedBox();
                  }
                  return CreateWorkRequestCellTime(
                    date: date.date!,
                    time: date.time!,
                    onDelete: () {},
                    showIcon: false,
                  );
                }),
              const SizedBox(height: 20),
              Center(
                child: elevatedButtonOpacityAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.createWorkRequestConfirm,
                  context,
                  _onSave,
                  AppColors.mainTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() async{
    await postWorkRequest(widget.createWorkRequest.workRequest.coOwnerId, widget.createWorkRequest);
    Navigator.pushNamedAndRemoveUntil(
        context,
        '/co_owner/work_requests',
          (Route<dynamic> route) => false,
      arguments: widget.createWorkRequest.workRequest.coOwnerId,
    );
  }
}
