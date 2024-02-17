import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/providers/profile/complete_profile_provider.dart';
import 'package:techconnect_frontend/shared/input_decorations.dart';
import 'package:techconnect_frontend/shared/constants.dart';

class PersonalDataForm extends StatefulWidget {

  final CompleteProfileProvider completeProfileForm;
  final String email;

  const PersonalDataForm({super.key, required this.completeProfileForm, required this.email});

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {

  TextEditingController _dateController = TextEditingController(); 

  @override
  void initState() {
    super.initState();

    // Inicializar completeProfileForm.email con el valor de userEmail
    widget.completeProfileForm.email = widget.email;
  }

  Future<void> _selectBirthDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
                ),
            dialogBackgroundColor:Colors.blue[900],
          ),
          child: child!,
        );
      },
    );

    if (_picked != null) {
      // ignore: use_build_context_synchronously
      final completeProfileForm = Provider.of<CompleteProfileProvider>(context, listen: false);
      String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(_picked);
      formattedDate = formattedDate.replaceFirst('T', ' ');
      DateTime dateTime = DateTime.parse(formattedDate);
      completeProfileForm.birthDate = dateTime;
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0].toString();
      });
     }
  }

  @override
  Widget build(BuildContext context) {

    final completeProfileForm = widget.completeProfileForm;
    final userEmail = widget.email;

    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Form(
        key: completeProfileForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 10,),

            // ** FIELD FIRST_NAME **
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Joe',
                  labelText: 'Nombre',
                  prefixIcon: Icons.person_add_alt_1
                ),
                initialValue: completeProfileForm.firstName,
                onChanged: (value) => completeProfileForm.firstName = value,
                validator: (value) {
                  if (value != null && value.length > 0) return null;
                  return CommonConstant.FIRST_NAME_ERROR;
                },
              ),
            ),

            const SizedBox(height: 15,),

            // ** FIELD LAST_NAME **
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Lopez',
                  labelText: 'Apellido',
                  prefixIcon: Icons.person_add_alt_1
                ),
                initialValue: completeProfileForm.lastName,
                onChanged: (value) => completeProfileForm.lastName = value,
                validator: (value) {
                  if (value != null && value.length > 0) return null;
                  return CommonConstant.LAST_NAME_ERROR;
                },
              ),
            ),

            const SizedBox(height: 15,),

            // ** FIELD EMAIL **
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Email',
                  hintText: 'joe@example.com',
                  prefixIcon: Icons.email_rounded
                ),
                initialValue: userEmail,
                enabled: false,
                onChanged: (value) => completeProfileForm.email = userEmail,
              ),
            ),

            const SizedBox(height: 15,),

            // ** FIELD PHONE_NUMBER **
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Telefono',
                  hintText: '+54 444444',
                  prefixIcon: Icons.phone
                ),
                initialValue: completeProfileForm.phoneNumber,
                onChanged: (value) => completeProfileForm.phoneNumber = value,
                validator: (value) {
                  if (value != null && value.length > 0) return null;
                  return CommonConstant.LAST_NAME_ERROR;
                },
              ),
            ),

            const SizedBox(height: 15,),

            // ** FIELD BIRTHDAY **
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                controller: _dateController,
                 decoration: InputDecorations.authInputDecoration(
                  labelText: 'Fecha de Nacimiento',
                  hintText: '01/01/2000',
                  prefixIcon: Icons.calendar_today
                ),
                // initialValue: completeProfileForm.birthDate,
                readOnly: true,
                onTap: () {
                  _selectBirthDate();
                },
                // onChanged: (value) => loginForm.username = value,
              ),
            ),

            const SizedBox(height: 15,),

            // ** FIELD PERSONAL_STATUS **
            Padding(
              padding:  const EdgeInsets.only(left: 20.0, right: 20.0),
              child: DropdownButtonFormField(
                decoration: InputDecorations.authInputDecoration(
                  hintText: "Estado Sentimental",
                  labelText: "Estado Sentimental",
                  prefixIcon: Icons.sentiment_satisfied_alt_outlined
                ),
                value: completeProfileForm.personalStatus,
                items: const [
                  DropdownMenuItem(value: "Soltero/a", child: Text("Soltero/a")),
                  DropdownMenuItem(value: "Casado/a", child: Text("Casado/a")),
                  DropdownMenuItem(value: "Novio/a", child: Text("Novio/a")),
                  DropdownMenuItem(value: "En una relacion", child: Text("En una relacion")),
                ],
                onChanged: (value) => completeProfileForm.personalStatus = value!,
              ),
            )

          ],
        ),
      ),
    );
  }


}