import 'package:blablacook/cook/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'add.dart';
import 'book.dart';
import 'offer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.orange,
          items: [
            TabItem<dynamic>(icon: Icons.home, title: 'Accueil'),
            TabItem<dynamic>(icon: Icons.restaurant, title: 'Demande'),
            TabItem<dynamic>(icon: Icons.add, title: 'Ajouter'),
            TabItem<dynamic>(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 0,
          onTap: (int i) {
            setState(() {
              _idx = i;
            });
          },
        ),
        body: Center(
            child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state.user,
          builder: (context, dynamic user) {
            switch (_idx) {
              case 0:
                return Offer();
                break;
              case 1:
                return Book();
                break;
              case 2:
                return Add();
                break;
              case 3:
                return Profile();
                break;
            }
          },
        )));
  }
}
