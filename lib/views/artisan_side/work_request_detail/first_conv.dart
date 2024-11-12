import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/conv_cell.dart';
import 'package:front_syndic/api_handler/conversation/post_first_conv.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/divider/divider.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../models/work_request/work_request.dart';

class FirstConvFromWorkRequestArtisan extends StatefulWidget {
  const FirstConvFromWorkRequestArtisan({
    super.key,
    required this.workRequest,
  });

  final WorkRequest workRequest;

  @override
  State<FirstConvFromWorkRequestArtisan> createState() => _FirstConvFromWorkRequestArtisanState();
}

class _FirstConvFromWorkRequestArtisanState extends State<FirstConvFromWorkRequestArtisan> {
  final TextEditingController _messageController = TextEditingController();

  List<Conversation> _conversations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchConversationFromWorkRequest(widget.workRequest.uuid).then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _conversations = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: elevatedButtonOpacityAndTextColor(
            AppColors.mainBackgroundColor,
            AppText.createAMeeting,
            context,
            () {
              Navigator.pushNamed(
                context,
                '/work_requests/artisan/post_meeting',
                arguments: widget.workRequest,
              );
            },
            AppColors.mainTextColor,
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
          const SizedBox(height: 80),
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
                final conv = await postFirstConvArtisan(
                    widget.workRequest.uuid, _messageController.text);
                if (conv == null) {
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
