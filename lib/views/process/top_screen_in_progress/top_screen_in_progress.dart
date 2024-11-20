import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';

import '../../../text/fr.dart';
import '../../../widget/search_bar/search_bar.dart';

class TopScreenInProgress extends StatefulWidget {
  const TopScreenInProgress({
    super.key,
    required this.onChangedSearchValue,          //to factorize
    required this.onCategoryChanged,  //to factorize
    required this.listOfCategory,    //to factorize
  });

  final Function(String) onChangedSearchValue;
  final Function(String) onCategoryChanged;
  final List<String> listOfCategory;

  @override
  State<TopScreenInProgress> createState() => _TopScreenInProgressState();
}

class _TopScreenInProgressState extends State<TopScreenInProgress> {

  String category = AppText.conversation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      height: 170,
      child: Column(
        children: [
          SearchBarCustom(
            onChanged: widget.onChangedSearchValue,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${AppText.workRequestArtisanSideFilterBy}         ',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              DropdownButton(
                value: category,
                isExpanded: false,
                underline: Container(),
                iconSize: 50,
                items: widget.listOfCategory.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 22,
                        )
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) { //should return a widget to modify body
                  if(newValue != null) {
                    setState(() {
                      category = newValue;
                    });
                    widget.onCategoryChanged(newValue);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

