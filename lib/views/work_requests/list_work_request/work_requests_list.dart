import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/views/work_requests/list_work_request/selector_row.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_request_cell.dart';

import '../../../../api_handler/co_owner/get_work_request.dart';
import '../../../../models/work_request/work_request.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/add_floating_button.dart';
import '../../../../widget/search_bar/search_bar.dart';
import '../../../models/work_request/create_work_request.dart';

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
                                  Navigator.pushNamed(context,'/work_requests/detail',
                                      arguments: {'uuid':dataFiltered[index].uuid,'coOwnerId':widget.coOwnerUuid}
                                  );
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
          var createWorkRequest = CreateWorkRequest([],WorkRequest(),null);
          createWorkRequest.workRequest.coOwnerId = widget.coOwnerUuid;
          Navigator.pushNamed(context, '/work_requests/title_and_desc',arguments: createWorkRequest);
        }),
    );
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
}
