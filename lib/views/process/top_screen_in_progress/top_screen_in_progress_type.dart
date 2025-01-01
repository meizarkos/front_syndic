import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/top_screen_in_progress/top_screen_in_progress.dart';

import '../../../text/fr.dart';

class TopScreenInProgressCouncil extends StatefulWidget {
  const TopScreenInProgressCouncil({
    super.key,
    required this.onChangedSearchValue,
    required this.category,
    required this.onCategoryChanged,
  });

  final Function(String) onChangedSearchValue;
  final String category;
  final Function(String) onCategoryChanged;

  @override
  State<TopScreenInProgressCouncil> createState() => _TopScreenInProgressCouncilState();
}

class _TopScreenInProgressCouncilState extends State<TopScreenInProgressCouncil> {
  @override
  Widget build(BuildContext context) {
    return TopScreenInProgress(
        onAccountParameter: () {
          Navigator.pushNamed(context, '/account');
        },
        onChangedSearchValue: widget.onChangedSearchValue,
        onCategoryChanged: widget.onCategoryChanged,
        listOfCategory: AppText.inProgressListCouncil,
    );
  }
}

class TopScreenInProgressArtisan extends StatefulWidget {
  const TopScreenInProgressArtisan({
    super.key,
    required this.onChangedSearchValue,
    required this.category,
    required this.onCategoryChanged,
  });

  final Function(String) onChangedSearchValue;
  final String category;
  final Function(String) onCategoryChanged;

  @override
  State<TopScreenInProgressArtisan> createState() => _TopScreenInProgressArtisanState();
}

class _TopScreenInProgressArtisanState extends State<TopScreenInProgressArtisan> {

  @override
  Widget build(BuildContext context) {
    return TopScreenInProgress(
      onAccountParameter: () {
        Navigator.pushNamed(context, '/artisan/account');
      },
      onChangedSearchValue: widget.onChangedSearchValue,
      onCategoryChanged: widget.onCategoryChanged,
      listOfCategory: AppText.inProgressListCouncil,
    );
  }
}


class TopScreenInProgressUnion extends StatefulWidget {
  const TopScreenInProgressUnion({
    super.key,
    required this.onChangedSearchValue,
    required this.category,
    required this.onCategoryChanged,
  });

  final Function(String) onChangedSearchValue;
  final String category;
  final Function(String) onCategoryChanged;

  @override
  State<TopScreenInProgressUnion> createState() => _TopScreenInProgressUnionState();
}

class _TopScreenInProgressUnionState extends State<TopScreenInProgressUnion> {

  @override
  Widget build(BuildContext context) {
    return TopScreenInProgress(
      onAccountParameter: () {
        Navigator.pushNamed(context, '/account');
      },
      onChangedSearchValue: widget.onChangedSearchValue,
      onCategoryChanged: widget.onCategoryChanged,
      listOfCategory: AppText.inProgressListCouncil,
    );
  }
}

