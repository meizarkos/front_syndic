import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../../../models/work_request/work_request.dart';
import '../../../../../widget/decoration/text_field_deco_main.dart';
import '../../../../../widget/visibility/error.dart';

class RecapPatchWorkRequest extends StatefulWidget {
  const RecapPatchWorkRequest({
    super.key,
    required this.uuid,
    required this.fetchDetailWorkRequest,
    required this.onDelete,
    required this.onPatchApi,
  });

  final String uuid;
  final Future<WorkRequest?> Function(String?) fetchDetailWorkRequest;
  final Future<void> Function(String) onDelete;
  final Function(String, WorkRequest) onPatchApi;

  @override
  State<RecapPatchWorkRequest> createState() => _RecapPatchWorkRequestState();
}

class _RecapPatchWorkRequestState extends State<RecapPatchWorkRequest> {
  WorkRequest workRequestStatic = WorkRequest();

  bool errorVisibility = false;
  bool successVisibility = false;
  bool apiErrorVisibility = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.fetchDetailWorkRequest(widget.uuid).then((value) => {
      if(value != null){
        setState(() {
          workRequestStatic = value;
          titleController = TextEditingController(text: workRequestStatic.title ?? '');
          descriptionController = TextEditingController(text: workRequestStatic.description ?? '');
        })
      }
      else{
        setState(() {
          apiErrorVisibility = true;
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: textFieldMainDeco(AppText.titlePlaceHolder),
                  onChanged: (value) {
                    workRequestStatic.title = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: descriptionController,
                  decoration: textFieldMainDeco(AppText.descriptionPlaceHolder),
                  onChanged: (value) {
                    workRequestStatic.description = value;
                  },
                  maxLength: 1280,
                  maxLines: 10,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
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
                  errorText: AppText.recapError,
                ),
                Center(
                  child : ErrorVisibility(
                    errorVisibility: successVisibility,
                    errorText: AppText.recapSuccessModifying,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                SizedBox(
                  width: double.infinity,
                  child: elevatedButtonAndTextColor(
                    AppColors.mainBackgroundColor,
                      AppText.modify,
                      context,
                      modify,
                      AppColors.mainTextColor,
                  ),
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny*2),
                ElevatedButton(
                  onPressed: () => {
                    choiceDelete(),
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Background color with opacity
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    elevation: AppUIValue.elevation,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppText.delete,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 15),
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      );
  }

  void modify() async {
    if (workRequestStatic.category == null ||
        workRequestStatic.category == '' ||
        workRequestStatic.description == null ||
        workRequestStatic.description == '' ||
        workRequestStatic.title == null ||
        workRequestStatic.title == '') {
      setState(() {
        errorVisibility = true;
        successVisibility = false;
      });
    } else {
      setState(() {
        errorVisibility = false;
        successVisibility = true;
      });
      if(workRequestStatic.uuid == null) return;
      await widget.onPatchApi(workRequestStatic.uuid!, workRequestStatic);
    }
  }

  void choiceDelete(){
    showDialog(
      context: context, // Pass the context from your widget
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppText.recapDialogTitle),
          content: Text(AppText.recapDialogDelete),
          actions: [
            TextButton(
              child: Text(AppText.cancel),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without doing anything
              },
            ),
            TextButton(
              child: Text(AppText.confirm),
              onPressed: () {
                if(workRequestStatic.uuid == null) return;
                widget.onDelete(workRequestStatic.uuid!);
              }
            ),
          ],
        );
      },
    );
  }
}
