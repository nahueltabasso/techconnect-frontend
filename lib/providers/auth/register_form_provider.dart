import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/new_user_dto.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/context_service.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    print(username);
    print(email);
    print(password);
    print(confirmPassword);
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> registerUser() async {
    try {
      isLoading = true;
      BuildContext? context = ContextService().context!;
      final authService = Provider.of<AuthService>(context, listen: false);

      final newUserDto = NewUserDto(
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        googleUser: false,
        facebookUser: false,
        appleUser: false,
        firstLogin: false,
        roles: null,
        userLocked: false,
        failsAttemps: 0
      );

      final response = await authService.signUp(newUserDto);
      isLoading = false;
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

}