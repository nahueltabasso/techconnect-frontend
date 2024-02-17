import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_dto.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/context_service.dart';

class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';
  bool _isLoading = false;
  UserDto? userDto;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    print('$username - $password');
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> login() async {
    try {
      isLoading = true;
      BuildContext? context = ContextService().context!;
      final authService = Provider.of<AuthService>(context, listen: false);
      final response = await authService.signIn(username, password);

      isLoading = false;
      return response;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  UserDto getLoggedUser() {
    BuildContext? context = ContextService().context!;
    final authService = Provider.of<AuthService>(context, listen: false);
    return authService.userDto!;
  }

}