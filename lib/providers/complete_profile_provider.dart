import 'dart:io';

import 'package:flutter/material.dart';

class CompleteProfileProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  DateTime birthDate = DateTime.now();
  String studies = '';
  String biography = '';
  String personalStatus = '';
  File? profilePhoto = null;
  
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print("End valid form");
    return formKey.currentState?.validate() ?? false;
  }

}