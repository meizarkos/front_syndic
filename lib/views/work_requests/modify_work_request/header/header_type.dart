import 'package:flutter/material.dart';

import 'header.dart';

class HeaderCouncil extends StatelessWidget {
  const HeaderCouncil({
    super.key,
    required this.category,
    required this.onCategoryChange,
  });

  final String category;
  final Function(String) onCategoryChange;
  @override
  Widget build(BuildContext context) {
    return HeaderForModifyWorkRequest(
      category: category,
      onChangedCategory: onCategoryChange,
      onBack: ()=>{
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/co_owner/work_requests', // The new route
              (Route<dynamic> route) => false, // Remove all previous routes
        )
      },
    );
  }
}

class HeaderUnion extends StatelessWidget {
  const HeaderUnion({
    super.key,
    required this.category,
    required this.onCategoryChange,
  });

  final String category;
  final Function(String) onCategoryChange;

  @override
  Widget build(BuildContext context) {
    return HeaderForModifyWorkRequest(
      category: category,
      onChangedCategory: onCategoryChange,
      onBack: ()=>{
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/union/work_requests',
              (Route<dynamic> route) => false,
        )
      },
    );
  }
}

class HeaderUnionFromConversation extends StatelessWidget {
  const HeaderUnionFromConversation({
    super.key,
    required this.category,
    required this.onCategoryChange,
  });

  final String category;
  final Function(String) onCategoryChange;

  @override
  Widget build(BuildContext context) {
    return HeaderForModifyWorkRequest(
      category: category,
      onChangedCategory: onCategoryChange,
      onBack: ()=>{
        Navigator.pop(context)
      },
    );
  }
}

class HeaderCouncilFromConversation extends StatelessWidget {
  const HeaderCouncilFromConversation({
    super.key,
    required this.category,
    required this.onCategoryChange,
  });

  final String category;
  final Function(String) onCategoryChange;

  @override
  Widget build(BuildContext context) {
    return HeaderForModifyWorkRequest(
      category: category,
      onChangedCategory: onCategoryChange,
      onBack: ()=>{
        Navigator.pop(context)
      },
    );
  }
}

