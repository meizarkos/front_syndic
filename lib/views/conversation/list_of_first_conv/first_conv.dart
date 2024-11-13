import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/list_of_first_conv/first_conv_cell.dart';

import '../../../models/conversation/conversation.dart';
import '../../../text/fr.dart';

class FirstConv extends StatefulWidget {
  const FirstConv({
    super.key,
    required this.future,
    required this.title,
    required this.routeToDetailConv,
  });

  final Future<List<Conversation>?> future;
  final String title;
  final String routeToDetailConv;

  @override
  State<FirstConv> createState() => _FirstConvState();
}

class _FirstConvState extends State<FirstConv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
            style: Theme.of(context).textTheme.displayLarge
        ),
        centerTitle: true,  // Centers the title
        automaticallyImplyLeading: false, // Hides the back button
      ),
      body: FutureBuilder(
          future: widget.future,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text(AppText.apiErrorText));
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text(AppText.apiNoResult));
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if(index == snapshot.data!.length){
                    return const SizedBox(height: 50);
                  }
                  if(snapshot.data?[index]== null){
                    return SizedBox();
                  }
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, widget.routeToDetailConv, arguments: snapshot.data![index].uuid);
                    },
                    child : FirstConvCell(conversation: snapshot.data![index]),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
              );
            }
          }
      ),
    );
  }
}
