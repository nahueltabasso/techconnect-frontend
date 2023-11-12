import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/forgot_password_provider.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/ui/input_decorations.dart';
import 'package:techconnect_frontend/utils/constants.dart';
import 'package:techconnect_frontend/widgets/auth_background.dart';
import 'package:techconnect_frontend/widgets/card_container.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),

              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    
                    Text('Modificar contraseña', style: TextStyle(fontSize: 32,  )),
                    // Text('Modificar contraseña', style: Theme.of(context).textTheme.headlineSmall,),

                    const SizedBox(height: 15,),

                    Text(
                      CommonConstant.LEGEND_FORGOR_PASSWORD_SCREEN, 
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (context) => ForgotPasswordProvider(),
                      child: const _ForgotPasswordForm(),
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
                child: const Text('Iniciar Sesion', style: TextStyle(fontSize: 22, color: Colors.lightBlue),),
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              )

            ],
          ),
        ),
      ),
    );

  }
}


class _ForgotPasswordForm extends StatelessWidget {
  const _ForgotPasswordForm({super.key});

  void _forgotPassword(BuildContext context, AuthService authService, ForgotPasswordProvider forgotPasswordForm) async {
    print(forgotPasswordForm.email);
    if (!forgotPasswordForm.isValidForm()) return;
    forgotPasswordForm.isLoading = true;

    final String? response = await authService.forgotPassword(forgotPasswordForm.email);
    if (response == null) {
      Navigator.pushReplacementNamed(context, 'reset-password');
      NotificationService.showSuccessDialogAlert(context, 'Codigo Enviado', CommonConstant.FORGOT_PASSWORD_SUCCESS_LEGEND, null);
    } else {
      NotificationService.showErrorDialogAlert(context, response);
    }
    forgotPasswordForm.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final forgotPasswordForm = Provider.of<ForgotPasswordProvider>(context);

    return Container(
      child: Form(
        key: forgotPasswordForm.forgotPasswordFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // ** FIELD EMAIL **
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'joe@gmail.com',
                labelText: 'Email',
                prefixIcon: Icons.email_outlined
              ),
              onChanged: (value) => forgotPasswordForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                
                return regExp.hasMatch(value ?? '') ? null : CommonConstant.EMAIL_FIELD_ERROR;

              },
            ),

            const SizedBox(height: 30,),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minWidth: 300.0,
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.lightBlue,
              onPressed: forgotPasswordForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                _forgotPassword(context, authService, forgotPasswordForm);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(!forgotPasswordForm.isLoading ? 'Enviar Codigo' : 'Espere', style: const TextStyle(color: Colors.white),),
              ),
            ),

          ],
        ) 
      ),
    );
  }
}