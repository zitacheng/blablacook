import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final options = LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 1),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 500),

    // Animation duration (default 250)
    showItemDuration: Duration(seconds: 1),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: StoreConnector<dynamic, dynamic>(
          // ignore: always_specify_types
          converter: (store) => store.state.user,
          builder: (BuildContext context, dynamic user) {
            return CustomScrollView(slivers: <Widget>[
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 30),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60.0),
                          child: Image.network(
                            user.img.url as String,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                        Text(
                          user.username as String,
                          style: const TextStyle(
                            fontFamily: 'Amatic',
                            fontSize: 40,
                          ),
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: <Widget>[
                              for (dynamic val in user.cookType)
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Chip(
                                    padding: const EdgeInsets.all(0),
                                    backgroundColor: Colors.orangeAccent,
                                    label: Text(val as String,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'LatoLight')),
                                  ),
                                ),
                            ])),
                        const SizedBox(height: 30),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Plat cuisinés',
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'LatoLight')),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 1,
              ))
            ]);
          },
        ),
      ),
    ));
  }
}
