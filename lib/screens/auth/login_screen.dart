import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_dto.dart';
import 'package:techconnect_frontend/providers/auth/login_form_provider.dart';
import 'package:techconnect_frontend/screens/auth/forgor_password_screen.dart';
import 'package:techconnect_frontend/screens/auth/register_user_screen.dart';
// import 'package:techconnect_frontend/screens/home_screen.dart';
import 'package:techconnect_frontend/screens/profile/complete-profile/complete_profile_screen.dart';
import 'package:techconnect_frontend/screens/profile/complete-profile/invite_friends_screen.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/shared/input_decorations.dart';
import 'package:techconnect_frontend/shared/constants.dart';
import 'package:techconnect_frontend/shared/custom_page_route.dart';
import 'package:techconnect_frontend/widgets/auth_background.dart';
import 'package:techconnect_frontend/widgets/card_container.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
   
  static const String routeName = 'login';

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
                // onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
                onPressed: () => Navigator.of(context).push(
                  CustomPageRouter(child: const RegisterUserScreen(), typeTransition: 2, axisDirection: AxisDirection.right)
                ),
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

  void _login(BuildContext context) async {
    bool formValid = context.read<LoginFormProvider>().isValidForm();
    if (!formValid) return;
    String? response = await context.read<LoginFormProvider>().login();
    if (response == null) {
      // ignore: use_build_context_synchronously
      UserDto? loginUser = context.read<LoginFormProvider>().getLoggedUser();
      final Widget screen = loginUser.firstLogin ? const CompleteProfileScreen() : InviteFriendsScreen(userProfileId: 31,);
      Navigator.of(context).push(CustomPageRouter(child: screen, typeTransition: 2, axisDirection: AxisDirection.right));
      await Future.delayed(const Duration(milliseconds: 1000));
      NotificationService.showSuccessDialogAlert(context, 'Bienvenido', CommonConstant.LOGIN_SUCCESS_MESSAGE, null);
      return;
    } 
    NotificationService.showErrorDialogAlert(context, response);
  }

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

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
                // onPressed: () => Navigator.pushReplacementNamed(context, 'forgot-password'),
                onPressed: () => Navigator.of(context).push(
                  CustomPageRouter(child: const ForgotPasswordScreen(), typeTransition: 2, axisDirection: AxisDirection.right)
                ),
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
                _login(context);
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