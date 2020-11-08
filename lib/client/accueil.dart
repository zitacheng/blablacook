import 'package:blablacook/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../utils.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  Future<ParseResponse> fetchCook() async {
    final QueryBuilder<ParseObject> queryPost =
        QueryBuilder<ParseObject>(ParseObject('_User'))
          ..whereEqualTo('type', 'cook');

    final ParseResponse apiResponse = await queryPost.query();
    return apiResponse;
  }

  // Future<ParseResponse> BookCook(dynamic cook, dynamic client, dynamic date) async {
  //   final ParseObject query = ParseObject('Book')
  //     ..set('cook', cook)
  //     ..set('imclientg', client)
  //     ..set('cookDate', date);
  //   final ParseResponse apiResponse = await query.save();

  //   return apiResponse;
  // }

  // ignore: avoid_void_async
  void choiceBooking(dynamic data, bool choice) async {
    // data.set('accepted', choice);
    // final dynamic response = await data.save();
    // if (response.success == true) {
    //   showAlertDialog(context, 'Réussi', 'choix pris en compte');
    //   setState(() {});
    // } else {
    //   showAlertDialog(context, 'Erreur', 'veuillez réessayer');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<dynamic, dynamic>(
        // ignore: void_checks
        onInit: (dynamic store) async {
          final ParseResponse res = await fetchCook();
          return store
              .dispatch(MyAction(BlablacookActions.UpdateCook, res.results));
        },
        converter: (dynamic store) => store.state.cook,
        builder: (BuildContext context, dynamic cook) {
          return SafeArea(
            child: Scaffold(
                body: Center(
                    child: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Cuisiniers',
                    style: TextStyle(
                      fontFamily: 'Amatic',
                      fontSize: 40,
                    )),
              ),
              if (cook != null)
                for (dynamic data in cook.data)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cookProfile',
                          arguments: data);
                    },
                    child: Slidable(
                      actionPane: const SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: data.get('img') != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.network(
                                      data.get('img').url as String,
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.asset(
                                    'assets/images/noAvatar.png',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                          title: Text(data.get('username') as String),
                          subtitle: Text(data.get('username') as String),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Email',
                          color: Colors.blueGrey,
                          icon: Icons.mail_outline,
                          onTap: () {
                            createEmail(data.get('email') as String);
                          },
                        ),
                        IconSlideAction(
                          caption: 'Appeler',
                          color: Colors.blueAccent,
                          icon: Icons.phone,
                          onTap: () {
                            if (data.get('phone') != null)
                              makePhoneCall(data.get('phone') as String);
                            else {
                              showAlertDialog(context, 'Erreur',
                                  "Le cuisinier n'a pas fournis son numéro de téléphone");
                            }
                          },
                        ),
                        IconSlideAction(
                          caption: 'Réserver',
                          color: Colors.green,
                          icon: Icons.check,
                          onTap: () {
                            choiceBooking(data, false);
                          },
                        ),
                      ],
                    ),
                  )
            ]))),
          );
        });
  }
}
