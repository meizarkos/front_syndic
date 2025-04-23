import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:front_syndic/views/conversation/list_of_conv/conv_cell.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';
import 'package:front_syndic/text/fr.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/conversation/post_conv.dart';
import '../../../api_handler/work_request/fetch_work_request_detail.dart';
import '../../../models/to_screen/artisan_detail_work_request.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../conversation/list_of_conv/all_conv_type.dart';

class FirstContactArtisan extends StatefulWidget {
  const FirstContactArtisan({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  State<FirstContactArtisan> createState() => _FirstContactArtisanState();
}

class _FirstContactArtisanState extends State<FirstContactArtisan> {
  final TextEditingController _messageController = TextEditingController();

  List<Conversation> _conversations = [];
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();
  final sideText = SideConv.artisan;

  @override
  void initState() {
    super.initState();
    fetchConversationFromWorkRequest(widget.uuid).then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _conversations = value;
        });
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 500,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: elevatedButtonAndTextColor(
          AppColors.mainBackgroundColor,
          AppText.seeWorkRequest,
          context,
              () {
            Navigator.pushNamed(context,'/work_requests/artisan/detail',
                arguments: ArtisanWorkRequestDetailArg(
                  futureToFetchData: fetchWorkRequestDetailArtisan,
                  workRequestUuid: widget.uuid,
                  showContact: false,
                )
            );
          },
          AppColors.mainTextColor,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _conversations.length,
                  itemBuilder: (context, index) {
                    final conv = _conversations[index];
                    return ConvCell(
                      message: conv.message,
                      createdAt: conv.createdAt,
                      fromYou: conv.side == sideText ? true : false,
                      side: conv.side ?? SideConv.other,
                      sideText: sideText,
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
            ],
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
                final conv = await postFirstConvArtisanWorkRequest(
                  widget.uuid,
                  _messageController.text,
                );
                if (conv == null) {
                  return;
                }
                _messageController.clear();
                setState(() {
                  _conversations.add(conv);
                });
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent + 500,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      // Check if the controller is attached
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  ElevatedButton createAButtonAndIcon(String name, Widget icon, Function() goTo) {
    return ElevatedButton(
      onPressed: goTo,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainBackgroundColor, // Background color with opacity
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        textStyle: Theme.of(context).textTheme.displayMedium,
        elevation: AppUIValue.elevation,
        shadowColor: Colors.black.withOpacity(AppUIValue.opacityActionButtonShadow),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.mainTextColor,
            ),
          ),
        ],
      ),
    );
  }

  String? choseId() {
    if (_conversations.isNotEmpty && _conversations[0].uuid != null) {
      return _conversations[0].uuid;
    }
    return widget.uuid;
  }
}
