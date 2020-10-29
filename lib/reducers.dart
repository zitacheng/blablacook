import 'dart:developer';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'actions.dart';
import 'appstate.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      user: _userReducer(state.user, action),
      pics: _picsReducer(state.pics, action));
}

User _userReducer(User state, dynamic action) {
  if (action.key == BlablacookActions.UpdateUser) {
    return User(
      action.value.get('email') as String,
      action.value.get('type') as String,
      action.value.get('bio') as String,
      action.value.get('cookType') as List<dynamic>,
      action.value.get('img') as ParseFile,
      action.value.get('username') as String,
    );
  }
  return state;
}

Picture _picsReducer(Picture state, dynamic action) {
  if (action.key == BlablacookActions.updatePic) {
    return Picture(
      action.value as List<ParseObject>,
    );
  }
  return state;
}
