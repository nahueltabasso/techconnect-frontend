import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {

  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  // Fields of FORGOT PASSWORD FORM
  String email = '';

  // Fielsd of RESET PASSWORD FORM
  String code = '';
  String newPassword = '';
  String confirmPassword = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return forgotPasswordFormKey.currentState?.validate() ?? false;
  }

  bool isResetPasswordFormValid() {
    return resetPasswordFormKey.currentState?.validate() ?? false;
  }

}