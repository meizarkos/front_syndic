import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/appartment/appartment.dart';
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/add_floating_button.dart';
import 'package:front_syndic/widget/search_bar/search_bar.dart';

import '../../api_handler/appartment/get_all_appartment.dart';
import '../../api_handler/co_owner/get_co_owner_of_union.dart';
import '../../api_handler/union_artisans/get_all_artisan.dart';
import '../../models/adress/adress.dart';
import '../../models/co_owner/co_owner.dart';
import '../../models/user/createUser.dart';
import '../../models/user/user.dart';
import '../../widget/bottom/nav_bar_union.dart';
import '../co_owner/co_owner_cell/co_owner_cell.dart';

class UnionMain extends StatefulWidget {
  const UnionMain({super.key});

  @override
  State<UnionMain> createState() => _UnionMainState();
}

class _UnionMainState extends State<UnionMain> {
  String searchValue = '';
  String? category = AppText.unionCategories[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.listCoOwneTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: AppUIValue.spaceScreenToAny,
            right: AppUIValue.spaceScreenToAny,
            top: AppUIValue.spaceScreenToAny
        ),
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
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  iconSize: 40,
                  onPressed: ()=>{
                    Navigator.pushNamed(context, '/union/account')
                  },
                ),
              ],
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${AppText.workRequestArtisanSideFilterBy}  ",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Expanded(
                    child: DropdownButton(
                      value: category,
                      isExpanded: false,
                      underline: Container(),
                      iconSize: 35,
                      items:
                      AppText.unionCategories.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 14,
                              )
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            if(category == AppText.unionCategories[0])
              FutureBuilder(
                future: getAllArtisanInactiveUnion(),
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
                              Navigator.pushNamed(context,'/union/validate_artisan', arguments: dataFiltered[index].uuid);
                            },
                            child: CoOwnerCell(
                              title: dataFiltered[index].companyName,
                              subtitle: '${dataFiltered[index].lastName}\n${dataFiltered[index].firstName}',
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            else if(category == AppText.unionCategories[1])
              FutureBuilder(
                future: getAllArtisanActiveUnion(),
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
                              Navigator.pushNamed(context,'/union/block_artisan', arguments: dataFiltered[index].uuid);
                            },
                            child: CoOwnerCell(
                              title: dataFiltered[index].companyName,
                              subtitle: '${dataFiltered[index].lastName}\n${dataFiltered[index].firstName}',
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            else
              FutureBuilder(
                future: getAllApartment(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return const Center(child: Text(AppText.apiErrorText));
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(child: Text(AppText.apiNoResult));
                  } else {
                    final dataFiltered = lengthOfApartment(snapshot.data);
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
                              Navigator.pushNamed(context,'/union/user_detail', arguments: dataFiltered[index].uuid);
                            },
                            child: CoOwnerCell(
                              title: dataFiltered[index].user?.name,
                              subtitle: dataFiltered[index].adress?.street,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      ),
      floatingActionButton: addFloatingButton(() {
        final createUser = CreateUser(user: User(), adress: Adress());
        Navigator.pushNamed(context, '/union/create_user/name',arguments: createUser);
      }),
      bottomNavigationBar: bottomNavigationBarUnion(context, 0),
    );
  }

  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }

  List<Apartment>? lengthOfApartment(List<Apartment>? data) {
    return data?.where((apartment) {
      if (apartment.user?.name == null) {
        return false;
      }
      return apartment.user!.name!.toLowerCase().startsWith(searchValue.toLowerCase());
    }).toList();
  }

  List<Artisan>? lengthOfList(List<Artisan>? data) {
    return data?.where((artisan) {
      if (artisan.companyName == null) {
        return false;
      }
      return artisan.companyName!.toLowerCase().startsWith(searchValue.toLowerCase());
    }).toList();
  }
}
