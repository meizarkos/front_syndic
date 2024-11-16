import 'package:flutter/material.dart';

import '../../../color.dart';
import '../../../core_value.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/header/app_bar_back_button.dart';
import '../../work_requests/create_work_request/chose_time/cell_time.dart';
import '../../work_requests/create_work_request/recap.dart';

class DetailWorkRequestArtisanSide extends StatelessWidget {
  const DetailWorkRequestArtisanSide({
    super.key,
    required this.workRequest,
  });

  final WorkRequest workRequest;

  @override
  Widget build(BuildContext context) {
    const double spaceCate = 20;
    return Scaffold(
      appBar: appBarBackButton(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stringNullOrDefaultValue(
                    workRequest.title,
                    AppText.apiNoResult),
                style: Theme.of(context).textTheme.headlineLarge,
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
                      workRequest.description,
                      AppText.apiNoResult),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(height: spaceTitleDesc),
              divider(),
              const SizedBox(height: spaceCate),
              Text(
                AppText.category,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              Text(
                stringNullOrDefaultValue(
                    workRequest.category,
                    AppText.apiNoResult),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: spaceTitleDesc),
              divider(),
              const SizedBox(height: spaceCate),
              Text(
                AppText.workRequestArtisanSideDisponibility,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: spaceTitleDesc),
              if (workRequest.timings != null &&
                  workRequest.timings!.isNotEmpty)
                ...workRequest.timings!.map((date) {
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
                child: elevatedButtonOpacityAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.workRequestArtisanSideSendFirstMessage,
                  context,
                  ()=>_onSave(context),
                  AppColors.mainTextColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSave(BuildContext context) async {
    //Navigator.pushNamed(context,'/artisan_main/first_conv');
    Navigator.pushNamed(context, '/work_requests/artisan/first_conv', arguments: workRequest.uuid);
  }

  Divider divider() {
    return Divider(
        color: Colors.grey,
        thickness: 2
    );
  }
}
