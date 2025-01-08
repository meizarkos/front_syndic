import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/list_of_conv/conv_cell.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/divider/divider.dart';

import 'all_conv_type.dart';

class SeeConv extends StatefulWidget {
  const SeeConv({
    super.key,
    required this.uuid,
    required this.futureForGetConv,
    required this.futureForPostConv,
    required this.route,
    required this.sideText,
    required this.goToRequest,
    required this.goToMeeting,
    required this.goToEstimate,
    this.isFromWorkRequest = false,
  });

  final String uuid;
  final Future<List<Conversation>?> futureForGetConv;
  final Function futureForPostConv;
  final String route;
  final String sideText;
  final Function(String?) goToRequest;
  final Function(String?) goToMeeting;
  final Function(String?) goToEstimate;
  final bool isFromWorkRequest;


  @override
  State<SeeConv> createState() => _SeeConvState();
}



class _SeeConvState extends State<SeeConv> {
  final TextEditingController _messageController = TextEditingController();

  List<Conversation> _conversations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.futureForGetConv.then((value) {
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
        toolbarHeight: 100.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child : Row(
              children: [
                createButton(
                  AppText.createAMeeting,
                  ()=>{
                    Navigator.pushNamed(context, widget.route,
                      arguments: choseId(),
                    )
                  },
                  color: AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                  textColor: Colors.black,
                ),
                const SizedBox(width: 10),
                createButton(
                  AppText.seeWorkRequest,
                  ()=>{widget.goToRequest(choseId())},
                ),
                const SizedBox(width: 10),
                createButton(
                  AppText.seeMeeting,
                    ()=>widget.goToMeeting(_conversations[0].uuid),
                ),
                const SizedBox(width: 10),
                createButton(
                  AppText.seeEstimateDetail,
                  ()=>widget.goToEstimate(_conversations[0].uuid),
                ),
              ],
            )
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: _conversations.length,
              itemBuilder: (context, index) {
                final conv = _conversations[index];
                return ConvCell(
                  message: conv.message,
                  createdAt: conv.createdAt,
                  fromYou: conv.side == widget.sideText ? true : false,
                  side: conv.side ?? SideConv.other,
                  sideText: widget.sideText,
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
                final conv = await widget.futureForPostConv(
                  choseId(),
                  _messageController.text,
                );
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

  ElevatedButton createButton(String text, Function() onPressed,{Color color = AppColors.mainBackgroundColor,Color textColor = AppColors.mainTextColor}) {

    return elevatedButtonAndTextColor(
      color,
      text,
      context,
      onPressed,
      textColor,
    );
  }

  String? choseId(){
    if(widget.isFromWorkRequest){
      return widget.uuid;
    }
    else if(_conversations.isNotEmpty && _conversations[0].uuid != null){
      return _conversations[0].uuid;
    }
    return widget.uuid;
  }
}
