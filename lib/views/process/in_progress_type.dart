import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/in_progress_main.dart';
import 'package:front_syndic/views/process/top_screen_in_progress/top_screen_in_progress_type.dart';
import 'package:front_syndic/views/process/top_screen_in_progress/top_screen_route_handler.dart';

import '../../text/fr.dart';
import '../../widget/bottom/nav_bar_artisan.dart';
import '../../widget/bottom/nav_bar_council.dart';
import '../../widget/bottom/nav_bar_union.dart';

class InProgressCouncilConversation extends StatefulWidget {
  const InProgressCouncilConversation({super.key});

  @override
  State<InProgressCouncilConversation> createState() => _InProgressCouncilConversationState();
}

class _InProgressCouncilConversationState extends State<InProgressCouncilConversation> {
  var searchValue = '';
  var category = AppText.conversation;

  @override
  Widget build(BuildContext context) {
    return InProgressMain(
      top : TopScreenInProgressCouncil(
        onChangedSearchValue: _searchValueChange,
        category: category,
        onCategoryChanged: _categoryChange,
      ),
      body : topScreenRouteHandlerCouncil(searchValue,category),
      bottomBar : bottomNavigationBarCouncil(context,0),
    );
  }

  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }

  void _categoryChange(String value) {
    setState(() {
      category = value;
    });
  }
}


class InProgressArtisanConversation extends StatefulWidget {
  const InProgressArtisanConversation({super.key});

  @override
  State<InProgressArtisanConversation> createState() => _InProgressArtisanConversationState();
}

class _InProgressArtisanConversationState extends State<InProgressArtisanConversation> {

  var searchValue = '';
  var category = AppText.conversation;

  @override
  Widget build(BuildContext context) {
    return InProgressMain(
      top : TopScreenInProgressArtisan(
        onChangedSearchValue: _searchValueChange,
        category: category,
        onCategoryChanged: _categoryChange,
      ),
      body : topScreenRouteHandlerArtisan(searchValue,category),
      bottomBar : bottomNavigationBarArtisan(context,0),
    );
  }

  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }

  void _categoryChange(String value) {
    setState(() {
      category = value;
    });
  }
}


class InProgressUnion extends StatefulWidget {
  const InProgressUnion({super.key});

  @override
  State<InProgressUnion> createState() => _InProgressUnionState();
}

class _InProgressUnionState extends State<InProgressUnion> {
  var searchValue = '';
  var category = AppText.conversation;

  @override
  Widget build(BuildContext context) {
    return InProgressMain(
      top : TopScreenInProgressUnion(
        onChangedSearchValue: _searchValueChange,
        category: category,
        onCategoryChanged: _categoryChange,
      ),
      body : topScreenRouteHandlerUnion(searchValue,category),
      bottomBar : bottomNavigationBarUnion(context,0),
    );
  }

  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }

  void _categoryChange(String value) {
    setState(() {
      category = value;
    });
  }
}

