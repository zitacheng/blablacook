import 'dart:developer';

import 'package:blablacook/cook/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'add.dart';
import 'book.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _idx = 0;

  // var apiResponse = await ParseObject('Picture').getAll();
  // Future<List<dynamic>> fetchPicture() async {
  //   var apiResponse = await ParseObject('Picture').getAll();
  //   inspect(apiResponse);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.orange,
          // ignore: always_specify_types
          // ignore: prefer_const_literals_to_create_immutables
          items: <TabItem>[
            const TabItem<dynamic>(icon: Icons.restaurant, title: 'Demande'),
            const TabItem<dynamic>(icon: Icons.add, title: 'Ajouter'),
            const TabItem<dynamic>(
                icon: Icons.account_circle, title: 'Profile'),
          ],
          initialActiveIndex: 2,
          onTap: (int i) {
            setState(() {
              _idx = i;
            });
          },
        ),
        body: Center(
            child: StoreConnector<dynamic, dynamic>(
          // ignore: always_specify_types
          converter: (store) => store.state.user,
          builder: (BuildContext context, dynamic user) {
            switch (_idx) {
              case 0:
                return Book();
                break;
              case 1:
                return Add();
                break;
              case 2:
                return Profile();
                break;
              default:
                {
                  return Profile();
                }
            }
          },
        )));
  }
}
