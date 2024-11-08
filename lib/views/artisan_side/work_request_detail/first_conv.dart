import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/conversation/conv_cell.dart';
import 'package:front_syndic/api_handler/conversation/post_first_conv.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';
import 'package:front_syndic/widget/divider/divider.dart';

import '../../../models/work_request/work_request.dart';

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

  List<Conversation> _conversations = [Conversation(message: "Bonjour, je suis intéressé par votre demande", createdAt: "2021-09-01T12:00:00", side: "other")];



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
          Expanded(
            child: ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conv = _conversations[index];
                return ConvCell(
                  message: conv.message,
                  createdAt: conv.createdAt,
                  side: conv.side == 'artisan' ? true : false,
                );
              },
            ),
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
              onPressed: () async {
                final conv = await postFirstConvArtisan(widget.workRequest.uuid, _messageController.text);
                print(conv?.message!);
                if(conv == null) {
                  return;
                }
                _messageController.clear();
                setState(() {
                  _conversations.add(conv);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
