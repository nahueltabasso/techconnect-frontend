import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/auth/register_form_provider.dart';
import 'package:techconnect_frontend/screens/auth/login_screen.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/shared/custom_page_route.dart';
import 'package:techconnect_frontend/shared/input_decorations.dart';
import 'package:techconnect_frontend/shared/constants.dart';
import 'package:techconnect_frontend/widgets/auth_background.dart';
import 'package:techconnect_frontend/widgets/card_container.dart';

// ignore: must_be_immutable
class RegisterUserScreen extends StatelessWidget {

  static const String routeName = 'register';
   
  const RegisterUserScreen({Key? key}) : super(key: key);
  
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
                    Text('Crear Cuenta', style: Theme.of(context).textTheme.headlineLarge,),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (context) => RegisterFormProvider(),
                      child: const _RegisterForm(),
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
                child: const Text('Ya estas registrado?', style: TextStyle(fontSize: 22, color: Colors.lightBlue),),
                // onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                onPressed: () => Navigator.of(context).push(
                  CustomPageRouter(child: const LoginScreen(), typeTransition: 2, axisDirection: AxisDirection.left)
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({super.key});

  void _registerUser(BuildContext context) async {
    bool formValid = context.read<RegisterFormProvider>().isValidForm();
    if (!formValid) return;
    // TODO: Valid if the register is correct
    final String? response = await context.read<RegisterFormProvider>().registerUser();
    if (response == null) {
      Navigator.of(context).push(CustomPageRouter(child: const LoginScreen(), typeTransition: 2, axisDirection: AxisDirection.right));
      NotificationService.showSuccessDialogAlert(context, 'Registrado', CommonConstant.REGISTER_SUCCESS_MESSAGE, null);
    } 
    if (response != null && response != '') {
      NotificationService.showSnackbar(response);
    }
  }

  @override
  Widget build(BuildContext context) {

    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
        // TODO: Maintain the reference of key
        key: registerForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [

            // ** USERNAME FIELD **
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'joe',
                labelText: 'Nombre de Usuario',
                prefixIcon: Icons.account_circle
              ),
              onChanged: (value) => registerForm.username = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_USERNAME_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** EMAIL FIELD **
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'joe@gmail.com',
                labelText: 'Email',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => registerForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                
                return regExp.hasMatch(value ?? '') ? null : CommonConstant.EMAIL_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** PASSWORD FIELD **
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => registerForm.password = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_PASSWORD_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** CONFIRM PASSWORD FIELD **
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**********',
                labelText: 'Confirmar Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => registerForm.confirmPassword = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 50,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minWidth: 300.0,
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.lightBlue,
              onPressed: registerForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                // TODO Login form (submit)
                _registerUser(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(registerForm.isLoading ? 'Espere' : 'Registrarse', style: const TextStyle(color: Colors.white),),
              ),
            ),

            const SizedBox(height: 50,)

          ],
        ),
      ),
    );
  }


}