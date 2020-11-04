import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

dynamic showAlertDialog(BuildContext context, String title, String message) {
  final Widget okButton = FlatButton(
    child: const Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  final AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: <Widget>[
      okButton,
    ],
  );

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// ignore: always_specify_types
Future getImage(int way) async {
  final ImagePicker picker = ImagePicker();
  final dynamic pickedFile = await picker.getImage(
      source: way == 1 ? ImageSource.camera : ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path as String);
  }
  return null;
}

bool checkForm(BuildContext context, String username, String email,
    String password, String bio, bool cook, List<String> selectedType) {
  if (!username.isNotEmpty || password.isEmpty || email.isEmpty) {
    showAlertDialog(context, 'Erreur',
        "Veuillez remplir l'email , le nom d'utilisateur et le mot de passe.");
    return false;
  }
  if (!username.isNotEmpty ||
      username.length < 3 ||
      username.length > 14 ||
      !isAlphanumeric(username)) {
    showAlertDialog(context, 'Erreur',
        "Le nom d'utilisateur doit être entre 3 et 14 caractères et doit contenir aue des lettres ou chiffres.");
    return false;
  }
  if (!isEmail(email)) {
    showAlertDialog(
        context, 'Erreur', 'Veuillez utiliser une addresse email valide.');
    return false;
  }
  if (cook == true && selectedType.isEmpty) {
    showAlertDialog(context, 'Erreur',
        'Veuillez sélectionner au moins un type de cuisine.');
    return false;
  }
  if (bio.length > 136) {
    showAlertDialog(
        context, 'Erreur', 'Votre bio ne doit pas dépasser 136 caractère.');
    return false;
  }
  return true;
}
