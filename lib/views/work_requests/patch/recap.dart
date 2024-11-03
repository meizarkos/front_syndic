import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/work_request/fetch_work_request_detail.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../models/work_request/work_request.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
import '../../../widget/visibility/error.dart';

class RecapPatchWorkRequest extends StatefulWidget {
  const RecapPatchWorkRequest({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  State<RecapPatchWorkRequest> createState() => _RecapPatchWorkRequestState();
}

class _RecapPatchWorkRequestState extends State<RecapPatchWorkRequest> {
  WorkRequest workRequestStatic = WorkRequest();
  bool errorVisibility = false;
  bool apiErrorVisibility = false;
  bool isLoading = true;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar:
            appBarBackButton(context, title: AppText.createWorkRequestRecap),
        body: Column(
          children: [
            ErrorVisibility(
                errorVisibility: apiErrorVisibility,
                errorText: AppText.apiErrorText),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar:
            appBarBackButton(context, title: AppText.createWorkRequestRecap),
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
                const SizedBox(height: 2),
                TextField(
                  controller: titleController,
                  decoration: textFieldMainDeco(AppText.titlePlaceHolder),
                  onChanged: (value) {
                    workRequestStatic.title = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: 25),
                Text(
                  AppText.description,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 2),
                TextField(
                  controller: descriptionController,
                  decoration: textFieldMainDeco(AppText.descriptionPlaceHolder),
                  onChanged: (value) {
                    workRequestStatic.description = value;
                  },
                  maxLength: 1280,
                  maxLines: 10,
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 35, right: 35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: DropdownButton(
                    value: workRequestStatic.category,
                    isExpanded: true,
                    underline: Container(),
                    items: AppText.listOfTaskCategory.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == null) {
                        return;
                      }
                      setState(() {
                        workRequestStatic.category = newValue;
                      });
                    },
                  ),
                ),
                ErrorVisibility(
                  errorVisibility: errorVisibility,
                  errorText: AppText.createWorkRequestCategoryIsEmpty,
                ),
              ],
            ),
          ),
        ),bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: AppUIValue.spaceScreenToAny),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors.rowBackgroundColor,
                  onPressed: () => {},
                  label: Text(
                    AppText.modify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                )),
            const SizedBox(width: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () => {},
                  label: const Row(
                    children: [
                      Text(
                        AppText.delete,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 25),
                      // Add space between text and icon
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )),
          ],
                ),
        ),

      );
    }
  }

  Future<void> fetchData() async {
    try {
      final res = await fetchWorkRequesDetail(widget.uuid);
      if (res == null) {
        apiErrorVisibility = true;
        return;
      }
      setState(() {
        workRequestStatic = res;
        isLoading = false;
        titleController = TextEditingController(text: workRequestStatic.title);
        descriptionController =
            TextEditingController(text: workRequestStatic.description);
      });
    } catch (e) {
      apiErrorVisibility = true;
    }
  }



}
