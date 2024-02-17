import 'package:flutter/material.dart';
import 'package:techconnect_frontend/providers/complete_profile_provider.dart';
import 'package:techconnect_frontend/shared/input_decorations.dart';

class StudyHobbyForm extends StatefulWidget {

  final CompleteProfileProvider completeProfileForm;

  const StudyHobbyForm({super.key, required this.completeProfileForm});

  @override
  State<StudyHobbyForm> createState() => _StudyHobbyFormState();
}

class _StudyHobbyFormState extends State<StudyHobbyForm> {

  @override
  Widget build(BuildContext context) {

    final completeProfileForm = widget.completeProfileForm;

    return Container(
      alignment: AlignmentDirectional.topCenter,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 10,),

            // ** FIELD_STUDIES **
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                  labelText: "Estudios",
                  hintText: "",
                  prefixIcon: Icons.school_rounded
                ),
                initialValue: completeProfileForm.studies,
                onChanged: (value) => completeProfileForm.studies = value,
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecorations.authInputDecoration(
                  labelText: "Biografia",
                  hintText: "Cuentanos sobre ti",
                  prefixIcon: Icons.history
                ),
                initialValue: completeProfileForm.biography,
                onChanged: (value) => completeProfileForm.biography = value,
              ),
            )
          ],
        ),
      ),
    );
  }
}