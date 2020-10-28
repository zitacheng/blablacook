import 'package:meta/meta.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class User {
  String email = '';
  String type = '';
  String bio = '';
  // ignore: avoid_init_to_null
  List<dynamic> cookType = null;
  // ignore: avoid_init_to_null
  ParseFile img = null;
  // ignore: sort_constructors_first
  User(this.email, this.type, this.bio, this.cookType, this.img);
}

@immutable
class AppState {
  final User user;

  // ignore: sort_constructors_first
  const AppState({this.user});
}
