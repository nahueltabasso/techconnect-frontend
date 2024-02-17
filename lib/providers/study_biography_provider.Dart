import 'package:flutter/material.dart';

class StudyBiographyProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String studies = '';
  String biography = '';

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