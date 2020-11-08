import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final bool _loading = true;
  final List<String> _usernames = null;

  Future<ParseResponse> fetchCooks() async {
    final QueryBuilder<ParseObject> queryPost =
        QueryBuilder<ParseObject>(ParseObject('User'));

    final ParseResponse apiResponse = await queryPost.query();
    print(apiResponse.results);
    return apiResponse;
  }

  @override
  void initState() {
    fetchCooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _loading
            ? const Text('Loading...')
            : ListView.builder(
                itemCount: _usernames.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    _usernames[index],
                  );
                },
              ));
  }
}
