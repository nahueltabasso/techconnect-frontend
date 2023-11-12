import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {

  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  String email = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return forgotPasswordFormKey.currentState?.validate() ?? false;
  }

}