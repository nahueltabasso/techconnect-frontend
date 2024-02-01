import 'dart:io';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/providers/complete_profile_provider.dart';
import 'package:techconnect_frontend/screens/profile/forms/personal_data_form.dart';
import 'package:techconnect_frontend/screens/profile/forms/study_hobby_form.dart';
import 'package:techconnect_frontend/screens/profile/forms/upload_profile_photo_form.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/user_profile_servide.dart';

class CompleteProfileScreen extends StatefulWidget {
   
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  int activeStep = 0;
  int upperBound = 2;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    final completeProfileForm = Provider.of<CompleteProfileProvider>(context);
    final userEmail = authService.userDto!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Completa tu Perfil')),
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          color: Colors.black,
          onPressed: () {
            authService.signOut();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconStepper(
                icons: const [
                  Icon(Icons.person_4_rounded),
                  Icon(Icons.school_outlined),
                  Icon(Icons.photo_camera),
                  // Icon(Icons.location_city)
                ],
                // ActiveStep property set to activeStep variable defined above
                activeStep: activeStep,
                // This ensures step-tapping updates the activeStep
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              
              header(),
              
              SizedBox(
                height: 570,
                width: 500,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    PersonalDataForm(completeProfileForm: completeProfileForm, email: userEmail),
                    StudyHobbyForm(completeProfileForm: completeProfileForm),
                    UploadProfilePhotoForm(completeProfileForm: completeProfileForm,), 
                   // StudyHobbyForm(completeProfileForm: completeProfileForm)
                  ],
                  onPageChanged: (value) {
                    print('Active step $activeStep');
                    setState(() {
                      activeStep = value;
                    });
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  if (activeStep < upperBound) // Show in the previous steps
                    nextButton()
                  else if (activeStep == upperBound) // Show only in the last step
                    submitButton(completeProfileForm)
                  // nextButton()
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget submitButton(CompleteProfileProvider completeProfileForm) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
      ),
      child: const Text('Guardar', style: TextStyle(color: Colors.black),),
      onPressed: () => saveNewProfile(completeProfileForm),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
      ),
      onPressed: () {
        print("Current activeStep: $activeStep");
        // Accede a completeProfileForm
        final completeProfileForm = Provider.of<CompleteProfileProvider>(context, listen: false);

        if (activeStep == upperBound) {
          print(completeProfileForm.isValidForm());
          print("En este momento hay que ir al endpoint");
        }

        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            activeStep++;
          });
        }
      },
      child: const Text('Siguiente', style: TextStyle(color: Colors.black),),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            activeStep--;
          });
        }
      },
      child: const Text('Atras'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Datos Personales';

      case 1:
        return 'Estudios y Hobbies';

      case 2:
        return 'Foto de perfil';

      case 3:
        return 'Domicilio';
      default:
        return '';
    }
  }

  Future<void> saveNewProfile(CompleteProfileProvider completeProfileForm) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userProfileService = Provider.of<UserProfileService>(context, listen: false);

    print("Debajo se vera si el formulario es valido o no");
    print(completeProfileForm.isValidForm());

    final Map<String, dynamic> userProfileData = {
      'firstName': completeProfileForm.firstName,
      'lastName': completeProfileForm.lastName,
      'email': completeProfileForm.email,
      'phoneNumber': completeProfileForm.phoneNumber,
      'birthDate': completeProfileForm.birthDate.toString(),
      'verifiedProfile': false,
      'personalStatus': completeProfileForm.personalStatus,
      'studies': completeProfileForm.studies,
      'biography': completeProfileForm.biography,
      'userId': authService.userDto!.id,
      'activeProfile': true
    };

    File profilePhoto = completeProfileForm.profilePhoto!;

    UserProfileDto? userProfileDto = await userProfileService.saveProfile(userProfileData, profilePhoto);

    // print(newUserProfile);
  }

}


