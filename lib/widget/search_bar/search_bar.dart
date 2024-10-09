import 'package:flutter/material.dart';

import '../../text/fr.dart';


class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({
    super.key,
    required this.onChanged,
  });

  final Function onChanged;
  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBarCustom> {


  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        widget.onChanged(value);
      },
      maxLength: 50,
      maxLines: 1,
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Colors.grey[300],
        hintText: AppText.unionMainSearchBarEmpty,
        prefixIcon: const Icon(
            Icons.search,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.black), // Regular border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.black), // Remove violet border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.grey), // Border when not focused
        ),
      ),
    );
  }
}