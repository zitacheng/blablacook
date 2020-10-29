import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../actions.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<ParseResponse> fetchPicture(String id) async {
    final QueryBuilder<ParseObject> queryPost =
        QueryBuilder<ParseObject>(ParseObject('Picture'))
          ..whereEqualTo('userId', id);

    final ParseResponse apiResponse = await queryPost.query();
    return apiResponse;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<dynamic, Function(dynamic)>(onInit: (store) async {
      final ParseResponse res = await fetchPicture('Pm6hezt23K');
      return store.dispatch(MyAction(BlablacookActions.updatePic, res.results));
    },
        // ignore: always_specify_types
        converter: (store) {
      // Return a `VoidCallback`, which is a fancy name for a function
      // with no parameters. It only dispatches an Increment action.
      return (dynamic pic) {
        return store.dispatch(MyAction(BlablacookActions.updatePic, pic));
      };
      // ignore: always_specify_types
    }, builder: (BuildContext context, callback) {
      return Scaffold(
          body: SafeArea(
        child: Center(
          child: StoreConnector<dynamic, dynamic>(
            // ignore: always_specify_types
            converter: (store) => store.state,
            builder: (BuildContext context, dynamic state) {
              return Container(
                child: Column(children: <Widget>[
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60.0),
                    child: Image.network(
                      state.user.img.url as String,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Text(
                    state.user.username as String,
                    style: const TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40,
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        for (dynamic val in state.user.cookType)
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
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Plats cuisinés',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'LatoLight')),
                    ),
                  ),
                  if (state.pics != null && state.pics.data != null)
                    Expanded(
                      child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(10),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: <Widget>[
                            for (dynamic val in state.pics.data)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    val.get('img').url as String,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              ),
                          ]),
                    ),
                ]),
              );
            },
          ),
        ),
      ));
    });
  }
}
