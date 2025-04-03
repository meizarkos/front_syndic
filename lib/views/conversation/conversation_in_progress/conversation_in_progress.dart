import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/views/conversation/conversation_in_progress/cell_conversation.dart';

import '../../../models/conversation/conversation.dart';
import '../../../text/fr.dart';
import '../../../widget/search_bar/search_bar.dart';
import '../../process/body_in_progress/function_access_param.dart';
import '../../process/cell_in_progress/cell_in_progress.dart';

class ConversationInProgress extends StatefulWidget {
  const ConversationInProgress({
    super.key,
    required this.goToConvDetail,
    required this.fetchConversationInProgress,
    required this.bottomNavigationBar,
  });

  final Function(String) goToConvDetail;
  final Future<List<Conversation>?> fetchConversationInProgress;
  final BottomNavigationBar bottomNavigationBar;

  @override
  State<ConversationInProgress> createState() => _ConversationInProgressState();
}

class _ConversationInProgressState extends State<ConversationInProgress> {
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppText.convTitle),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SearchBarCustom(
              onChanged: (value) {
                setState(() {
                  searchValue = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: AppUIValue.spaceScreenToAny,
          ),
          FutureBuilder(
              future: widget.fetchConversationInProgress,
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
                    child: ListView.separated(
                      itemCount: dataFiltered.length + 1,
                      itemBuilder: (context, index) {
                        if (index == dataFiltered.length) {
                          return const SizedBox(height: space);
                        }
                        if (dataFiltered[index] == null) {
                          return SizedBox();
                        }
                        return GestureDetector(
                          onTap: () => widget.goToConvDetail(dataFiltered[index].uuid),
                          child: CellConversation(
                            status: dataFiltered[index].state ?? 'Unknown',
                            workRequestTitle:
                                getTitleWorkRequest(dataFiltered[index]),
                            lastMessage: getMessage(dataFiltered[index]),

                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: space);
                      },
                    ),
                  );
                }
              }),
        ]),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  List<dynamic>? filteredData(List<dynamic>? data) {
    if (searchValue.isEmpty) {
      return data;
    }
    return data?.where((element) {
      if (element.workRequest.title == null) {
        return false;
      }
      return element.workRequest.title!
          .toLowerCase()
          .startsWith(searchValue.toLowerCase());
    }).toList();
  }
}
