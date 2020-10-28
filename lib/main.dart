import 'package:blablacook/appstate.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:blablacook/login.dart';
import 'package:blablacook/cook/home.dart' as cookHome;
import 'package:blablacook/cook/profile.dart' as cookProfile;
import 'package:blablacook/cook/add.dart' as cookAdd;
import 'login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'reducers.dart';
// One simple action: Increment

// The reducer, which takes the previous count and increments it in response
// to an Increment action.

void main() {
  Parse().initialize('hVhUqLB5P7Lh3HqDLmgndx6sg7KlOvomuZNSUJl3',
      'https://parseapi.back4app.com/',
      masterKey: "yWrffJcmnXNViPRLTZAdObrSHuw3XqowuydWZtbm");

  final Store<dynamic> store =
      Store<AppState>(appReducer, initialState: AppState());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<dynamic> store;

  MyApp({Key key, this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
      store: store,
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (BuildContext context) => Login(),
          "/cookOffer": (BuildContext context) => cookHome.Home(),
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
