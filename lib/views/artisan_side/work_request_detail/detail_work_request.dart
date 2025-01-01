import 'package:flutter/material.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../color.dart';
import '../../../core_value.dart';
import '../../../models/to_screen/see_conv_arg.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/header/app_bar_back_button.dart';
import '../../work_requests/create_work_request/chose_time/cell_time.dart';
import '../../work_requests/create_work_request/recap/recap.dart';

class DetailWorkRequestArtisanSide extends StatefulWidget {
  const DetailWorkRequestArtisanSide({
    super.key,
    required this.futureToFetchData,
    required this.workRequestUuid,
    required this.showContact,
  });

  final Future<WorkRequest?> Function(String?) futureToFetchData;
  final String? workRequestUuid;
  final bool showContact;

  @override
  State<DetailWorkRequestArtisanSide> createState() => _DetailWorkRequestArtisanSideState();
}

class _DetailWorkRequestArtisanSideState extends State<DetailWorkRequestArtisanSide> {
  @override
  Widget build(BuildContext context) {
    const double spaceCate = 20;
    return Scaffold(
      appBar: appBarBackButton(context),
      body: SingleChildScrollView(
        child: FutureBuilder( 
          future: widget.futureToFetchData(widget.workRequestUuid),
          builder: (BuildContext context, AsyncSnapshot<WorkRequest?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError ||snapshot.data == null) {
              return Center(
                child: Text(
                  AppText.apiNoResult,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              );
            }
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stringNullOrDefaultValue(
                        data.title,
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
                          data.description,
                          AppText.apiNoResult),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: spaceTitleDesc),
                  divider(),
                  const SizedBox(height: spaceTitleDesc),
                  Text(
                    AppText.adress,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: spaceTitleDesc),
                  Container(
                    padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      "${data.adress?.country ?? ''}\n\n"
                          "${data.adress?.city ?? ''}, ${data.adress?.region ?? ''}\n\n"
                          "${data.adress?.street ?? ''}\n\n"
                          "${data.adress?.comment ?? ''}",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: spaceCate),
                  Text(
                    AppText.category,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: spaceTitleDesc),
                  Text(
                    stringNullOrDefaultValue(
                        data.category,
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
                  if (data.timings != null &&
                      data.timings!.isNotEmpty)
                    ...data.timings!.map((date) {
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
                  widget.showContact ? Center(
                      child: elevatedButtonAndTextColor(
                        AppColors.mainBackgroundColor,
                        AppText.workRequestArtisanSideSendFirstMessage,
                        context,
                            ()=>_onSave(context),
                        AppColors.mainTextColor,
                      )
                  ) : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSave(BuildContext context){
    if(widget.workRequestUuid == null){
      return;
    }
    Navigator.pushNamed(context, '/work_requests/artisan/first_conv',
        arguments: SeeConvArg(uuid : widget.workRequestUuid!, futureToFetchData: fetchConversationFromWorkRequest)
    );
  }

  Divider divider() {
    return Divider(
        color: Colors.grey,
        thickness: 2
    );
  }
}
