import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/decoration/text_field_deco_main.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../models/work_request/create_work_request.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/elevated_button_opacity.dart';

class TitleAndDesc extends StatefulWidget {
  const TitleAndDesc({
    super.key,
    required this.createWorkRequest,
    required this.route,
  });

  final CreateWorkRequest createWorkRequest;
  final String route;

  @override
  State<TitleAndDesc> createState() => _TitleAndDescState();
}

class _TitleAndDescState extends State<TitleAndDesc> {
  var errorVisible = false;
  String? titleValue = '';
  String? descriptionValue= '';

  @override
  void initState(){
    super.initState();
    titleValue = widget.createWorkRequest.workRequest.title;
    descriptionValue = widget.createWorkRequest.workRequest.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: textFieldMainDeco(AppText.titlePlaceHolder),
                onChanged: (value) {
                  titleValue = value;
                },
                maxLength: 50,
              ),
              const SizedBox(height: 15),
              TextField(
                decoration : textFieldMainDeco(AppText.description),
                onChanged: (value) {
                  descriptionValue = value;
                },
                maxLength: 1280,
                maxLines: 10,
              ),
              const SizedBox(height: 7),
              ErrorVisibility(errorVisibility: errorVisible, errorText: AppText.createTitleWorkErrorText),
              const SizedBox(height: 7),
              Center(
                child: elevatedButtonAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  () async {
                    if(titleValue == null || titleValue == '' || descriptionValue == null || descriptionValue == ''){
                      setState(() {
                        errorVisible = true;
                      });
                      return;
                    }
                    widget.createWorkRequest.workRequest.title = titleValue;
                    widget.createWorkRequest.workRequest.description = descriptionValue;
                    /*final permission = await _checkPermissions();
                    if(!permission){
                      return;
                    }
                    final camera = await _getCamera();
                    widget.createWorkRequest.camera = camera;
                    if(widget.createWorkRequest.camera == null){
                      _goToCategory();
                      return;
                    }
                    _goToCamera();*/
                    _goToCategory();
                  },
                  AppColors.mainTextColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<CameraDescription> getCamera() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

  void _goToCategory() {
    Navigator.pushNamed(context, widget.route,arguments: widget.createWorkRequest);
  }

  void _goToCamera() {
    Navigator.pushNamed(context, '/work_requests/pictures', arguments: widget.createWorkRequest);
  }

  Future<bool> _checkPermissions() async {
    PermissionStatus status = await Permission.camera.status;

    if(status.isPermanentlyDenied){
      _goToCategory();
      return false;
    }

    if (!status.isGranted || status.isLimited || status.isProvisional) {
      status = await Permission.camera.request();
    }

    if(!status.isGranted || status.isPermanentlyDenied){
      _goToCategory();
      return false;
    }
    return true;
  }

  Future<CameraDescription> _getCamera() async {
    final cameras = await availableCameras();
    return cameras.first;
  }
}
