enum BlablacookActions { UpdateUser, CleareUser, UpdatePic, ClearPic }

class MyAction {
  BlablacookActions key;
  dynamic value;
  // ignore: sort_constructors_first
  MyAction(this.key, this.value);

  // ThunkAction<AppState> getDate = (Store<AppState> store) {
  //   print("store is $store, gender is $gender, name is $name");
  // }
}
