import 'package:meta/meta.dart';

class User {
  String email = '';
  String type = '';
  User(this.email, this.type);
}

@immutable
class AppState {
  final User user;

  AppState({this.user});
}
