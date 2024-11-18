import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/cell_in_progress/cell_in_progress.dart';

import '../../../text/fr.dart';

class BodyInProgress extends StatefulWidget {
  const BodyInProgress({
    super.key,
    required this.future,
    required this.routeToDetail,
    required this.searchValue,
    required this.returnWorkRequestTitle,
    required this.returnDesc,
    required this.descSize,
    this.returnThirdText,
    this.thirdTextSize,
  });

  final Future future;
  final String routeToDetail;
  final String? searchValue;
  final Function(dynamic) returnWorkRequestTitle;
  final Function(dynamic) returnDesc;
  final int descSize;
  final Function(dynamic)? returnThirdText;
  final int? thirdTextSize;

  @override
  State<BodyInProgress> createState() => _BodyInProgressState();
}

class _BodyInProgressState extends State<BodyInProgress> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapshot){
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
            return ListView.separated(
              itemCount: dataFiltered.length + 1,
              itemBuilder: (context, index) {
                if (index == dataFiltered.length) {
                  return const SizedBox(height: 15);
                }
                if(dataFiltered[index]== null){
                  return SizedBox();
                }
                return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, widget.routeToDetail, arguments: snapshot.data![index].uuid);
                    },
                    child : CellInProgress(
                        workRequestTitle: widget.returnWorkRequestTitle(dataFiltered[index]),
                        desc: widget.returnDesc(dataFiltered[index]),
                        descSize: widget.descSize,
                        thirdText: widget.returnThirdText != null ? widget.returnThirdText!(dataFiltered[index]) : null,
                        thirdTextSize: widget.thirdTextSize,
                    ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
            );
          }
        }
    );
  }

  List<dynamic>? filteredData(List<dynamic>? data) {
    if(widget.searchValue == null || widget.searchValue!.isEmpty){
      return data;
    }
    return data?.where((element) {
      if (element.workRequest.title == null) {
        return false;
      }
      return element.workRequest.title!.toLowerCase().startsWith(widget.searchValue!.toLowerCase());
    }).toList();
  }
}
