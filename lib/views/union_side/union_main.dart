import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/search_bar/search_bar.dart';

import '../../api_handler/co_owner/get_co_owner_of_union.dart';
import '../../models/co_owner/co_owner.dart';
import 'co_owner_cell/co_owner_cell.dart';

class UnionMain extends StatefulWidget {
  const UnionMain({super.key});

  @override
  State<UnionMain> createState() => _UnionMainState();
}

class _UnionMainState extends State<UnionMain> {
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: AppUIValue.spaceScreenToAny,
            right: AppUIValue.spaceScreenToAny,
            top: 40),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: SearchBarCustom(
                    onChanged: _searchValueChange,
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  iconSize: 40,
                  onPressed: () {
                    //Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            FutureBuilder(
              future: fetchAllCoOwnersFromUnion(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const Center(child: Text(AppText.apiErrorText));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text(AppText.apiNoResult));
                } else {
                  final dataFiltered = lengthOfList(snapshot.data);
                  if (dataFiltered == null || dataFiltered.isEmpty) {
                    return const Center(child: Text(AppText.apiNoResult));
                  }
                  final size = dataFiltered.length + 1;
                  return Expanded(
                    child: GridView.builder(
                      itemCount: size,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      itemBuilder: (context, index) {
                        if (index == dataFiltered.length) {
                          return const SizedBox(height: 25);
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,'/co_owner_main', arguments: dataFiltered[index].uuid);
                          },
                          child: CoOwnerCell(
                            title: dataFiltered[index].name,
                            subtitle: dataFiltered[index].adress?.street,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () {
            //Navigator.pushNamed(context, '/register_co_owner');
          },
          backgroundColor: Colors.black,
          label: const Row(
            children: [
              Text(
                AppText.unionMainAddButton,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8), // Add space between text and icon
              Icon(
                Icons.add_box,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }

  List<CoOwner>? lengthOfList(List<CoOwner>? data) {
    return data?.where((coOwner) {
      if (coOwner.name == null) {
        return false;
      }
      return coOwner.name!.toLowerCase().startsWith(searchValue.toLowerCase());
    }).toList();
  }
}