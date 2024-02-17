import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/password_dto.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/context_service.dart';

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

  Future<String?> forgotPassword() async {
    try {
      isLoading = true;
      BuildContext? context = ContextService().context!;
      final authService = Provider.of<AuthService>(context, listen: false);

      final response = await authService.forgotPassword(email);
      isLoading = false;
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> resetPassword() async {
    try {
      isLoading = true;
      BuildContext? context = ContextService().context!;
      final authService = Provider.of<AuthService>(context, listen: false);

      final passwordDTO = PasswordDTO(
        code: code, 
        newPassword: newPassword, 
        confirmPassword: confirmPassword
      );

      final response = await authService.resetPassword(passwordDTO);
      isLoading = false;
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

}