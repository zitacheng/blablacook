import 'package:blablacook/cook/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'add.dart';
import 'book.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _idx = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.orange,
          // ignore: always_specify_types
          // ignore: prefer_const_literals_to_create_immutables
          items: <TabItem<dynamic>>[
            const TabItem<dynamic>(icon: Icons.restaurant, title: 'Demande'),
            const TabItem<dynamic>(icon: Icons.add, title: 'Ajouter'),
            const TabItem<dynamic>(
                icon: Icons.account_circle, title: 'Profile'),
            const TabItem<dynamic>(icon: Icons.settings, title: 'Gestion'),
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
                case 3:
                  return Add();
                  break;
                default:
                  {
                    return Profile();
                  }
              }
            },
          ),
        ));
  }
}
