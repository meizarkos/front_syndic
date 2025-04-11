import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/appartment/appartment.dart';
import 'package:front_syndic/models/work_request/create_work_request.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../color.dart';
import '../../../models/adress/adress.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/text_style/text_style_main_color.dart';
import '../../co_owner/co_owner_detail/row_of_text_and_icon.dart';

const spaceInsideColumn = 25.0;

class UserDetail extends StatefulWidget {
  const UserDetail({
    super.key,
    required this.fetchData,
    required this.apartmentUuid,
  });

  final Future<Apartment?> fetchData;
  final String? apartmentUuid;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {

  Apartment? apartment;
  Adress? adress;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.fetchData.then((value) {
      setState(() {
        apartment = value;
        adress = apartment?.adress;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.unionUserDetail),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    else if(isLoading == false && apartment == null) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.unionUserDetail),
        body: const Center(child: Text(AppText.apiNoResult)),
      );
    }
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.unionUserDetail),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Card(
                elevation: AppUIValue.elevation,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                  decoration: decorationRoundMainColor(),
                  child: Column(
                    children: [
                      Text(
                        trimText(
                          apartment?.user?.name ?? AppText.noStringNameForCowner,
                          11,
                        ),
                        style: getTextStyleMainColor(19.0),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: spaceInsideColumn),
                      rowOfTextAndIcon(
                          'assets/co_owner.svg',
                          adress?.city ?? '',
                          context
                      ),
                      const SizedBox(height: spaceInsideColumn),
                      Text(
                        '${adress?.country ?? ''}\n${adress?.street ?? ''}',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: spaceInsideColumn),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: elevatedButtonOpacity(
                          AppColors.mainTextColor.withOpacity(AppUIValue.opacityActionButton),
                          AppText.buttonCreateARequest,
                          context,
                              () => goToCreateWorkRequest(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: elevatedButtonOpacity(
                          AppColors.mainTextColor.withOpacity(AppUIValue.opacityActionButton),
                          AppText.buttonSeeInvoice,
                          context,
                              () => Navigator.pushNamed(context, '/invoice'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: elevatedButtonAndTextColor(
                AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                AppText.modifyTheseData,
                context,
                    () {
                  Navigator.pushNamed(context, '/union/user_modify', arguments: apartment?.userId);
                },
                Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToCreateWorkRequest(BuildContext context) {
    Navigator.pushNamed(context,'union/work_requests/title_and_desc',
      arguments: CreateWorkRequest(
        [],
        WorkRequest(userId: apartment?.userId),
        null,
        Adress(),
      ),
    );
  }
}
