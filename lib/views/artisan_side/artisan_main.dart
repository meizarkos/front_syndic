import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/views/artisan_side/cell_work_request.dart';

import '../../api_handler/work_request/fetch_all_work_request.dart';
import '../../api_handler/work_request/fetch_work_request_detail.dart';
import '../../models/to_screen/artisan_detail_work_request.dart';
import '../../models/work_request/work_request.dart';
import '../../text/fr.dart';
import '../../widget/search_bar/search_bar.dart';

class ArtisanMain extends StatefulWidget {
  const ArtisanMain({super.key});

  @override
  State<ArtisanMain> createState() => _ArtisanMainState();
}

class _ArtisanMainState extends State<ArtisanMain> {

  var searchValue = '';
  String? category = AppText.listOfTaskCategoryWithNull[AppText.listOfTaskCategoryWithNull.length - 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SearchBarCustom(
              onChanged: _searchValueChange,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppText.workRequestArtisanSideFilterBy,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Expanded(
                  child: DropdownButton(
                    value: category,
                    isExpanded: true,
                    underline: Container(),
                    items:
                    AppText.listOfTaskCategoryWithNull.map((String value) {
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
              ],
            ),
          ),
          FutureBuilder(
            future: fetchAllWorkRequestArtisan(),
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
                          Navigator.pushNamed(context, "/work_requests/artisan/detail",
                                arguments: ArtisanWorkRequestDetailArg(
                                    workRequestUuid:dataFiltered[index].uuid,
                                    futureToFetchData: fetchWorkRequestDetailArtisan,
                                    showContact: true,
                                ),
                            );
                        },
                        child: CellWorkRequestArtisanSide(
                          title: dataFiltered[index].title,
                          subtitle: dataFiltered[index].description,
                          adress: dataFiltered[index].adress,
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
    );
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
      return workRequest.title!.toLowerCase().startsWith(searchValue.toLowerCase()) &&
          (category == AppText.listOfTaskCategoryWithNull[AppText.listOfTaskCategoryWithNull.length - 1] || workRequest.category == category);
    }).toList();
  }
}
