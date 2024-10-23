import 'package:flutter/material.dart';

class SelectorHistoricCell extends StatelessWidget {
  const SelectorHistoricCell({
    super.key,
    required this.onTap,
    required this.title,
    required this.selected,
  });

  final VoidCallback onTap;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        child : Text(
            title,
            style: _textStyle(selected),
        ),
      ),
    );
  }

  TextStyle _textStyle(bool selected) {
    return TextStyle(
      color: selected ? Colors.black : Colors.grey,
      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      fontSize: 20,
    );
  }
}
