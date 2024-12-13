import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../core_value.dart';
import '../../../models/timing/timing_estimate.dart';
import '../../../widget/button/add_floating_button.dart';
import '../../../widget/divider/divider.dart';
import 'cell_timing_estimate.dart';

class TimingEstimateView extends StatefulWidget {
  const TimingEstimateView({
    super.key,
    required this.fetchData,
    required this.uuid,
    //required this.valueOfValidation, //1 , 2 , 4
    required this.valueValidateByYou, //all value where the timing is validated by you (length = 3)
    required this.routeToPost,
  });

  final Function(String?) fetchData;
  final String? uuid;
  //final int valueOfValidation;
  final List<int> valueValidateByYou;
  final String routeToPost;

  @override
  State<TimingEstimateView> createState() => _TimingEstimateViewState();
}

class _TimingEstimateViewState extends State<TimingEstimateView> {
  bool _viewNotValidate = false,
      _viewAllValidate = false,
      _viewValidateByYou = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.timingEstimate),
      body: FutureBuilder(
        future: widget.fetchData(widget.uuid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text(AppText.apiErrorText));
          }
          final List<TimingEstimate> timings =
              snapshot.data! as List<TimingEstimate>;
          List<TimingEstimate> noValidation = [];
          List<TimingEstimate> validateByYou = [];
          List<TimingEstimate> validateByAll = [];

          for (var timingEstimate in timings) {
            //all validate
            if (timingEstimate.status == timingEstimate.statusGoal) {
              validateByAll.add(timingEstimate);
            }
            //validate by you
            else if (isValidateByYou(timingEstimate)) {
              validateByYou.add(timingEstimate);
            }
            //no validation
            else {
              noValidation.add(timingEstimate);
            }
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getListTitle(
                    () {
                      setState(() {
                        _viewNotValidate = !_viewNotValidate;
                      });
                    },
                    AppText.timingEstimateNotYetValidate,
                    _viewNotValidate,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  if (noValidation.isNotEmpty && _viewNotValidate)
                    ...noValidation.map((timingEstimate) {
                      return CellTimingEstimate(
                        timingEstimate: timingEstimate,
                        isValidate: false,
                      );
                    }),
                  divider(1, Colors.black),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  getListTitle(
                    () {
                      setState(() {
                        _viewValidateByYou = !_viewValidateByYou;
                      });
                    },
                    AppText.timingEstimateValidateByYou,
                    _viewValidateByYou,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  if (validateByYou.isNotEmpty && _viewValidateByYou)
                    ...validateByYou.map((timingEstimate) {
                      return CellTimingEstimate(
                        timingEstimate: timingEstimate,
                        isValidate: true,
                      );
                    }),
                  divider(1, Colors.black),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  getListTitle(
                    () {
                      setState(() {
                        _viewAllValidate = !_viewAllValidate;
                      });
                    },
                    AppText.timingEstimateValidate,
                    _viewAllValidate,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  if (validateByAll.isNotEmpty && _viewAllValidate)
                    ...validateByAll.map((timingEstimate) {
                      return CellTimingEstimate(
                        timingEstimate: timingEstimate,
                        isValidate: true,
                      );
                    }),
                  divider(1, Colors.black),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: addFloatingButton(() {
        final TimingEstimate timingEstimate = TimingEstimate(
          estimateId: widget.uuid,
        );
        Navigator.pushReplacementNamed(context, widget.routeToPost, arguments: timingEstimate);
      }),
    );
  }

  bool isValidateByYou(TimingEstimate timingEstimate) {
    return widget.valueValidateByYou.contains(timingEstimate.status);
  }

  Icon getIcon(bool view) {
    return Icon(
      view ? Icons.keyboard_arrow_down_sharp : Icons.keyboard_arrow_right_sharp,
      size: 40,
    );
  }

  GestureDetector getListTitle(VoidCallback onTap, String title, bool view) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Spacer(),
          getIcon(view),
        ],
      ),
    );
  }
}
