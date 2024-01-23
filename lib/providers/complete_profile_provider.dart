import 'package:flutter/material.dart';

class CompleteProfileProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  DateTime? birthDate;
  String studies = '';
  String biography = '';
  String personalStatus = '';
  
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(firstName);
    print(lastName);
    print(email);
    print(phoneNumber);
    print(birthDate);
    print(studies);
    print(biography);
    print(personalStatus);
    return formKey.currentState?.validate() ?? false;
  }

}