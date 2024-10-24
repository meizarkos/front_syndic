import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/views/work_requests/list_work_request/selector_row.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_request_cell.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../api_handler/co_owner/get_work_request.dart';
import '../../../../models/work_request/work_request.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/add_floating_button.dart';
import '../../../../widget/search_bar/search_bar.dart';

class WorkRequestsList extends StatefulWidget {
  const WorkRequestsList({
    super.key,
    required this.coOwnerUuid,
  });

  final String coOwnerUuid;

  @override
  State<WorkRequestsList> createState() => _WorkRequestsListState();
}

class _WorkRequestsListState extends State<WorkRequestsList> {
  final List<String> _workRequests = [AppText.workRequestsPending, AppText.workRequestsHistory];
  final futureList = [fetchWorkRequestFromCoOwnerPending, fetchWorkRequestFromCoOwnerPast];
  String searchValue = '';
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: AppUIValue.spaceScreenToAny, top : 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _workRequests.asMap().entries.map((entry) {
                        int index = entry.key; // Access the index
                        String title = entry.value; // Access the title
                        var isSelected = index == indexSelected;
                        return SelectorHistoricCell(
                          title: title,
                          selected: isSelected,
                          onTap : ()=> _changeSelected(title),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: SearchBarCustom(
                      onChanged: _searchValueChange,
                    ),
                  ),
                  const SizedBox(height: 15),
                  FutureBuilder(
                    future: futureList[indexSelected](widget.coOwnerUuid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return const Center(child: Text(AppText.apiErrorText));
                      } else if (snapshot.data!.isEmpty) {
                        return const Center(child: Text(AppText.apiNoResult));
                      } else {
                        final dataFiltered = filteredData(snapshot.data);
                        if (dataFiltered == null || dataFiltered.isEmpty) {
                          return const Center(child: Text(AppText.apiNoResult));
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: dataFiltered.length + 1,
                            itemBuilder: (context, index) {
                              if (index == dataFiltered.length) {
                                return const SizedBox(height: 15);
                              }
                              return GestureDetector(
                                onTap: () {
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => WorkRequestDetail(workRequest: dataFiltered[index])));
                                },
                                child: WorkRequestCell(
                                  title: dataFiltered[index].title,
                                  subtitle: dataFiltered[index].description,
                                  timings: dataFiltered[index].timings,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
        ),
        floatingActionButton: addFloatingButton(()async {
          final CameraDescription camera = await getCamera();
          final permission = await _checkPermissions();
          if(!permission){
            return;
          }
          _goTo(camera);
        }),
    );
  }

  void _goTo(CameraDescription camera){
    Navigator.pushNamed(context, '/work_requests/pictures',arguments: camera);
  }

  void _changeSelected(String title) {
    setState(() {
      indexSelected = _workRequests.indexOf(title);
    });
  }
  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }

  List<WorkRequest>? filteredData(List<WorkRequest>? data) {
    return data?.where((workRequest) {
      if (workRequest.title == null) {
        return false;
      }
      return workRequest.title!.toLowerCase().startsWith(searchValue.toLowerCase());
    }).toList();
  }

  Future<CameraDescription> getCamera() async {
    final cameras = await availableCameras();
    return cameras.first;
  }

  void _goToCategory() {
    Navigator.pushNamed(context, '/work_requests/category');
  }

  Future<bool> _checkPermissions() async {
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if(!status.isGranted){
      _goToCategory();
      return false;
    }
    return true;
  }
}
