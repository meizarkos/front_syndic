import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../../color.dart';
import '../../../../models/work_request/create_work_request.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/elevated_button_opacity.dart';
import '../../../../widget/decoration/decoration_round_main_color.dart';
import '../chose_time/cell_time.dart';

const double spaceTitleDesc = 20;
const double spaceCate = 20;

class RecapForCreateWorkRequest extends StatefulWidget {
  const RecapForCreateWorkRequest({
    super.key,
    required this.createWorkRequest,
    required this.onPost,
  });

  final CreateWorkRequest createWorkRequest;
  final Function(CreateWorkRequest) onPost;

  @override
  State<RecapForCreateWorkRequest> createState() => _RecapForCreateWorkRequestState();
}

class _RecapForCreateWorkRequestState extends State<RecapForCreateWorkRequest> {
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
                stringNullOrDefaultValue(
                    widget.createWorkRequest.workRequest.title,
                    AppText.apiNoResult),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              divider(),
              const SizedBox(height: spaceCate),
              Text(
                AppText.description,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              Container(
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                decoration: decorationRoundMainColor(),
                child: Text(
                  stringNullOrDefaultValue(
                      widget.createWorkRequest.workRequest.description,
                      AppText.apiNoResult),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: spaceTitleDesc),
              divider(),
              const SizedBox(height: spaceCate),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${AppText.category}:    ", // First part of the text
                      style: Theme.of(context).textTheme.displayMedium, // Apply displaySmall
                    ),
                    TextSpan(
                      text: widget.createWorkRequest.workRequest.category ?? AppText.apiNoResult, // Second part of the text
                      style: Theme.of(context).textTheme.displaySmall, // Apply displayMedium
                    ),
                  ],
                ),
              ),
              const SizedBox(height: spaceTitleDesc),
              divider(),
              const SizedBox(height: spaceCate),
              Text(
                AppText.workRequestArtisanSideDisponibility,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              if (widget.createWorkRequest.workRequest.timings != null &&
                  widget.createWorkRequest.workRequest.timings!.isNotEmpty)
                ...widget.createWorkRequest.workRequest.timings!.map((date) {
                  if (date.date == null || date.time == null) {
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
                child: elevatedButtonAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  ()=>widget.onPost(widget.createWorkRequest),
                  AppColors.mainTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Divider divider() {
    return Divider(
      color: Colors.grey,  // Couleur de la ligne
      thickness: 2,        // Épaisseur de la ligne
    );
  }
}
