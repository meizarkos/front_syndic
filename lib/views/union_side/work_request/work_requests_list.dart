import 'package:flutter/material.dart';
import 'package:front_syndic/views/union_side/work_request/work_request_cell.dart';

import '../../../api_handler/co_owner/get_work_request.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  const Text(
                    "FEUR",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: fetchWorkRequestFromCoOwner(widget.coOwnerUuid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return const Center(child: Text(AppText.apiErrorText));
                      } else if (snapshot.data!.isEmpty) {
                        return const Center(child: Text(AppText.apiNoResult));
                      } else {
                        final dataFiltered = snapshot.data as List<WorkRequest>;
                        final size = dataFiltered.length + 1;
                        return Expanded(
                          child: ListView.builder(
                            itemCount: size,
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
        )
    );
  }
}
