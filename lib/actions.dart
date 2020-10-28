enum BlablacookActions { UpdateUser }

class MyAction {
  BlablacookActions key;
  dynamic value;
  MyAction(this.key, this.value);

  // ThunkAction<AppState> getDate = (Store<AppState> store) {
  //   print("store is $store, gender is $gender, name is $name");
  // }
}
