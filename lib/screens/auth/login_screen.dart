import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_dto.dart';
import 'package:techconnect_frontend/providers/login_form_provider.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/ui/input_decorations.dart';
import 'package:techconnect_frontend/utils/constants.dart';
import 'package:techconnect_frontend/widgets/auth_background.dart';
import 'package:techconnect_frontend/widgets/card_container.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Bienvenido', style: Theme.of(context).textTheme.headlineLarge,),
                    const SizedBox(height: 15,),
                    Text('Accede a tu cuenta', style: Theme.of(context).textTheme.headlineSmall,),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: const _LoginForm(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.lightBlue.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: const Text('Crear una nueva cuenta', style: TextStyle(fontSize: 22, color: Colors.lightBlue),),
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
              )
            ],
          ),
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  void _login(BuildContext context, LoginFormProvider loginForm, AuthService authService) async {
    if (!loginForm.isValidForm()) return;
    loginForm.isLoading = true;

    // TODO: Valid if the login is correct
    final String? response = await authService.signIn(loginForm.username, loginForm.password);
    print(response);
    if (response == null) {
      final UserDto? loginUser = authService.userDto;
      final String screen = loginUser!.firstLogin ? 'complete-profile':'home';
      // final String screen = loginUser!.firstLogin ? 'add-location':'add-location';

      Navigator.pushReplacementNamed(context, screen);
      NotificationService.showSuccessDialogAlert(context, 'Bienvenido', CommonConstant.LOGIN_SUCCESS_MESSAGE, null);
    } else {
      // TODO: Show error message
      // NotificationService.showSnackbar(response);
      // ignore: use_build_context_synchronously
      NotificationService.showErrorDialogAlert(context, response);
    }
    loginForm.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Container(
      child: Form(
        // TODO: Mantener referencia al key
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [

            // ** FIELD USERNAME **
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'joe',
                labelText: 'Nombre de usuario',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => loginForm.username = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_USERNAME_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** FIELD PASSWORD **
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_PASSWORD_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 15,),

            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.lightBlue.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  alignment: Alignment.bottomRight
                ),
                child: const Text('Olvidaste tu contraseña?', style: TextStyle(fontSize: 14, color: Colors.lightBlue),),
                onPressed: () => Navigator.pushReplacementNamed(context, 'forgot-password'),
              ),
            ),

            const SizedBox(height: 10,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minWidth: 300.0,
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.lightBlue,
              onPressed: loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                // TODO Login form (submit)
                _login(context, loginForm, authService);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(loginForm.isLoading ? 'Espere' : 'Login', style: const TextStyle(color: Colors.white),),
              ),
            ),

            const SizedBox(height: 50,)

          ],
        ),
      ),
    );
  }
}