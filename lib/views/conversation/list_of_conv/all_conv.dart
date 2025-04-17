import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_syndic/views/conversation/list_of_conv/conv_cell.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';
import 'package:front_syndic/text/fr.dart';
import 'all_conv_type.dart';

class SeeConv extends StatefulWidget {
  const SeeConv({
    super.key,
    required this.uuid,
    required this.routeToBack,
    required this.futureForGetConv,
    required this.futureForPostConv,
    required this.sideText,
    required this.goToRequest,
    required this.goToMeeting,
    required this.goToEstimate,
    required this.goToTimingEstimate,
  });

  final String uuid;
  final VoidCallback routeToBack;
  final Future<List<Conversation>?> futureForGetConv;
  final Function futureForPostConv;
  final String sideText;
  final Function(String?) goToRequest;
  final Function(String?) goToMeeting;
  final Function(String?) goToEstimate;
  final Function(String?) goToTimingEstimate;

  @override
  State<SeeConv> createState() => _SeeConvState();
}

class _SeeConvState extends State<SeeConv> {
  final TextEditingController _messageController = TextEditingController();

  List<Conversation> _conversations = [];
  bool isLoading = true;
  final ScrollController _scrollController = ScrollController();
  bool _isPanelOpen = true;

  @override
  void initState() {
    super.initState();
    widget.futureForGetConv.then((value) {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          _isPanelOpen = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: widget.routeToBack,
          ),
          title: Text(
              _conversations[0].workRequest?.title ?? AppText.conversation),
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
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isPanelOpen)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 250,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.black26)
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            createAButtonAndIcon(
                              AppText.seeWorkRequest,
                              Icon(
                                Icons.work,
                                color: Colors.black,
                                // Change this to any color you want
                                size: 15, // Optional: Adjust the size
                              ),
                              () => widget.goToRequest(choseId()),
                            ),
                            const SizedBox(height: 10),
                            createAButtonAndIcon(
                              AppText.timing,
                              Icon(
                                Icons.schedule,
                                color: Colors.black,
                                // Change this to any color you want
                                size: 15, // Optional: Adjust the size
                              ),
                              () => widget.goToMeeting(_conversations[0].uuid),
                            ),
                            const SizedBox(height: 10),
                            createAButtonAndIcon(
                              AppText.estimate,
                              Icon(
                                Icons.money,
                                color: Colors.black,
                                // Change this to any color you want
                                size: 15, // Optional: Adjust the size
                              ),
                              () => widget.goToEstimate(_conversations[0].uuid),
                            ),
                            const SizedBox(height: 10),
                            createAButtonAndIcon(
                              AppText.timingEstimateTitle,
                              SvgPicture.asset(
                                'assets/tools.svg',
                                width: 15,
                                height: 15,
                              ),
                              () => widget
                                  .goToTimingEstimate(_conversations[0].uuid),
                            ),
                          ],
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Transform.rotate(
                      angle: _isPanelOpen ? 3.1416 : 0, // Rotate when open
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8), // Adjust padding as needed
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white, // Optional: make the icon white for contrast
                          size: 20, // Optional: control icon size
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPanelOpen = !_isPanelOpen;
                      });
                    },
                  ),
                ],
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
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent + 500,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
              ),
            ],
          ),
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

  ElevatedButton createAButtonAndIcon(
      String name, Widget icon, Function() goTo) {
    return ElevatedButton(
      onPressed: goTo,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainBackgroundColor,
        // Background color with opacity
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        textStyle: Theme.of(context).textTheme.displayMedium,
        elevation: AppUIValue.elevation,
        shadowColor:
            Colors.black.withOpacity(AppUIValue.opacityActionButtonShadow),
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
