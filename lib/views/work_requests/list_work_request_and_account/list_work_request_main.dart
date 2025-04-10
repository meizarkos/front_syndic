import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_request_cell.dart';

import '../../../api_handler/work_request/get_work_request_id.dart';
import '../../../core_value.dart';
import '../../../models/adress/adress.dart';
import '../../../models/work_request/create_work_request.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';
import '../../../widget/bottom/nav_bar_council.dart';
import '../../../widget/button/add_floating_button.dart';
import '../../../widget/search_bar/search_bar.dart';

class ListWorkRequestMain extends StatefulWidget {
  const ListWorkRequestMain({
    super.key,
    required this.goToAccount,
    required this.fetchWorkRequestPending,
    required this.goToModifyDemand,
    required this.goToCreateWorkRequest,
    required this.bottom
  });

  final VoidCallback goToAccount;
  final Future<List<WorkRequest>?> Function() fetchWorkRequestPending;
  final Function(String) goToModifyDemand;
  final Function() goToCreateWorkRequest;
  final BottomNavigationBar bottom;

  @override
  State<ListWorkRequestMain> createState() => _ListWorkRequestMainState();
}

class _ListWorkRequestMainState extends State<ListWorkRequestMain> {
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.titleNextWork),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: AppUIValue.spaceScreenToAny),
          Container(
            margin: const EdgeInsets.only(
              left: AppUIValue.spaceScreenToAny,
              right: AppUIValue.spaceScreenToAny,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: SearchBarCustom(
                    onChanged: _searchValueChange,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  iconSize: 40,
                  onPressed: widget.goToAccount,
                ),
              ],
            ),
          ),
          Expanded(
            // Ensure ListView takes the remaining space
            child: FutureBuilder(
              future: widget.fetchWorkRequestPending(),
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
                  return ListView.builder(
                    itemCount: dataFiltered.length + 1,
                    itemBuilder: (context, index) {
                      if (index == dataFiltered.length) {
                        return const SizedBox(height: 50);
                      }
                      return GestureDetector(
                        onTap: () {
                          if (dataFiltered[index].uuid == null) {
                            return;
                          }
                          widget.goToModifyDemand(dataFiltered[index].uuid!);
                        },
                        child: WorkRequestCell(
                          title: dataFiltered[index].title,
                          subtitle: dataFiltered[index].description,
                          type: dataFiltered[index].category,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: addFloatingButton(
        widget.goToCreateWorkRequest,
      ),
      bottomNavigationBar: widget.bottom,
    );
  }

  /*void _changeSelected(String title) {
    setState(() {
      indexSelected = _workRequests.indexOf(title);
    });
  }*/
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
      return workRequest.title!
          .toLowerCase()
          .startsWith(searchValue.toLowerCase());
    }).toList();
  }
}
