import 'package:blablacook/appstate.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:blablacook/login.dart';
import 'package:flutter/services.dart';
// ignore: library_prefixes
import 'package:blablacook/cook/home.dart' as cookHome;
import 'login.dart';
import 'reducers.dart';

void main() {
  Parse().initialize('hVhUqLB5P7Lh3HqDLmgndx6sg7KlOvomuZNSUJl3',
      'https://parseapi.back4app.com/',
      masterKey: 'yWrffJcmnXNViPRLTZAdObrSHuw3XqowuydWZtbm');

  final Store<dynamic> store =
      Store<AppState>(appReducer, initialState: const AppState());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<dynamic> store;

  // ignore: sort_constructors_first
  const MyApp({Key key, this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white,
    ));

    return StoreProvider<dynamic>(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        // ignore: always_specify_types
        routes: {
          '/': (BuildContext context) => const Login(),
          '/cookOffer': (BuildContext context) => cookHome.Home(),
        },
        title: 'blablacook',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
