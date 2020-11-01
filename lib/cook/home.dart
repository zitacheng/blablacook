import 'package:blablacook/cook/profile.dart';
import 'package:blablacook/cook/settings.dart';
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
    return WillPopScope(
        onWillPop: () async => !Navigator.of(context).userGestureInProgress,
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Scaffold(
                bottomNavigationBar: ConvexAppBar(
                  backgroundColor: Colors.orange,
                  items: const <TabItem<dynamic>>[
                    TabItem<dynamic>(icon: Icons.restaurant, title: 'Demande'),
                    TabItem<dynamic>(icon: Icons.add, title: 'Ajouter'),
                    TabItem<dynamic>(
                        icon: Icons.account_circle, title: 'Profile'),
                    TabItem<dynamic>(icon: Icons.settings, title: 'Gestion'),
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
                    converter: (dynamic store) => store.state.user,
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
                          return Settings();
                          break;
                        default:
                          {
                            return Profile();
                          }
                      }
                    },
                  ),
                )),
          ),
        ));
  }
}
