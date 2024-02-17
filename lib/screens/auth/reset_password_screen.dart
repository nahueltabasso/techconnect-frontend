import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/auth/forgot_password_provider.dart';
import 'package:techconnect_frontend/screens/auth/login_screen.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/shared/custom_page_route.dart';
import 'package:techconnect_frontend/shared/input_decorations.dart';
import 'package:techconnect_frontend/shared/constants.dart';
import 'package:techconnect_frontend/widgets/auth_background.dart';
import 'package:techconnect_frontend/widgets/card_container.dart';

class ResetPasswordScreen extends StatelessWidget {

  static const String routeName = 'reset-password';

  const ResetPasswordScreen({super.key});

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
                    
                    const Text('Restablecer Contraseña', style: TextStyle(fontSize: 28,  )),
                    // Text('Restablecer Contraseña', style: Theme.of(context).textTheme.headlineSmall,),

                    const SizedBox(height: 15,),

                    Text(
                      CommonConstant.LEGEND_RESET_PASSWORD_SCREEN, 
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.left,
                    ),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create: (context) => ForgotPasswordProvider(),
                      child: const _ResetPasswordForm(),
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


class _ResetPasswordForm extends StatelessWidget {
  const _ResetPasswordForm({super.key});

  void _resetPassword(BuildContext context, AuthService authService, ForgotPasswordProvider forgotPasswordForm) async {
    bool formValid = context.read<ForgotPasswordProvider>().isResetPasswordFormValid();
    if (!formValid) return;

    final String? response = await context.read<ForgotPasswordProvider>().resetPassword();
    if (response == null) {
      // Navigator.pushReplacementNamed(context, 'login')
      Navigator.of(context).push(CustomPageRouter(child: const LoginScreen(), typeTransition: 2, axisDirection: AxisDirection.right));
      NotificationService.showSuccessDialogAlert(context, 'Contraseña Restablecida', CommonConstant.RESET_PASSWORD_SUCCESS_SCEEN, 'login');
    } else {
      NotificationService.showErrorDialogAlert(context, response);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final forgotPasswordForm = Provider.of<ForgotPasswordProvider>(context);

    return Container(
      child: Form(
        key: forgotPasswordForm.resetPasswordFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // ** FIELD VERIFICATION CODE **
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '123456',
                labelText: 'Codigo de Verificacion',
                prefixIcon: Icons.verified
              ),
              onChanged: (value) => forgotPasswordForm.code = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.FIELD_CODE_RESET_PASSWORD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** FIELD NEW PASSWORD **
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**********',
                labelText: 'Contraseña Nueva',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => forgotPasswordForm.newPassword = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_PASSWORD_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** FIELD CONFIRM PASSWORD **
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '**********',
                labelText: 'Confirmar Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => forgotPasswordForm.confirmPassword = value,
              validator: (value) {
                if (value != null && value.length > 0) return null;
                return CommonConstant.EMPTY_PASSWORD_FIELD_ERROR;
              },
            ),

            const SizedBox(height: 30,),

            // ** SUBMIT BUTTON **
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              minWidth: 300.0,
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.lightBlue,
              onPressed: forgotPasswordForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                _resetPassword(context, authService, forgotPasswordForm);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                child: Text(!forgotPasswordForm.isLoading ? 'Modificar Contraseña' : 'Espere', style: const TextStyle(color: Colors.white),),
              ),
            ),

          ],
        ) 
      ),
    );
  }
}