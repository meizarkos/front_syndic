import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../models/work_request/create_work_request.dart';
import '../../../text/fr.dart';
import '../../../widget/visibility/error.dart';

class WorkRequestCategory extends StatefulWidget {
  const WorkRequestCategory({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  State<WorkRequestCategory> createState() => _WorkRequestCategoryState();
}

class _WorkRequestCategoryState extends State<WorkRequestCategory> {
  String? category;
  bool errorVisibility = false;

  @override
  void initState(){
    super.initState();
    if(widget.createWorkRequest.workRequest.category != null) {
      category = widget.createWorkRequest.workRequest.category;
    }
    else{
      category = 'Plomberie';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(15),
            child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: AppText.createCategoryTitle,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                )
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.only(top: 15,bottom: 15, left: 35, right: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), // Round the corners
              border: Border.all(
                  color: Colors.black,
                  width: 2.0), // Add border color and width
            ),
            child: DropdownButton(
              value: category,
              isExpanded: true,
              underline: Container(),
              items:
              AppText.listOfTaskCategory.map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  category = newValue;
                });
              },
            ),
          ),
          ErrorVisibility(
              errorVisibility: errorVisibility,
              errorText: AppText.createWorkRequestCategoryIsEmpty),
          elevatedButtonOpacityAndTextColor(
              AppColors.mainBackgroundColor,
              AppText.save,
              context,
              _onPressed,
              AppColors.mainTextColor,
          ),
        ],
      ),
    );
  }

  void _onPressed() {
    if (category == null || category == '') {
      setState(() {
        errorVisibility = true;
      });
    } else {
      widget.createWorkRequest.workRequest.category = category!;
      Navigator.pushNamed(context, '/work_requests/chose_date_time', arguments: widget.createWorkRequest);
    }
  }
}
