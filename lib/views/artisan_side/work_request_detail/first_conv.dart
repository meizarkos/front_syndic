import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';
import 'package:front_syndic/widget/divider/divider.dart';

import '../../../models/work_request/work_request.dart';
import '../../../widget/header/app_bar_back_button.dart';

class FirstConv extends StatefulWidget {
  const FirstConv({
    super.key,
    required this.workRequest,
  });

  final WorkRequest workRequest;

  @override
  State<FirstConv> createState() => _FirstConvState();
}

class _FirstConvState extends State<FirstConv> {

  final TextEditingController _messageController = TextEditingController();

  List<Conversation> _conversations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        leading: IconButton(
          icon : Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {Navigator.pop(context);},
        ),
        title: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trimText(stringNullOrDefaultValue(widget.workRequest.title,AppText.noTitleForWork), 20),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                trimText(stringNullOrDefaultValue(widget.workRequest.description,AppText.noDescriptionWorkRequest), 100),
                style: Theme.of(context).textTheme.displaySmall,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          SizedBox(
            width: MediaQuery.of(context).size.width, // Full width divider
            child: divider(2, Colors.grey),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: AppText.workRequestMessageHint,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _messageController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
