import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/providers/profile/complete_profile_provider.dart';
import 'package:techconnect_frontend/screens/profile/add_location_screen.dart';
import 'package:techconnect_frontend/screens/profile/forms/personal_data_form.dart';
import 'package:techconnect_frontend/screens/profile/forms/study_hobby_form.dart';
import 'package:techconnect_frontend/screens/profile/forms/upload_profile_photo_form.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/shared/custom_page_route.dart';

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
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

              if (completeProfileForm.isLoading)
                const Column(
                  children:  [
                    SizedBox(height: 50,),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),

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
                  ],
                  onPageChanged: (value) {
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
                    submitButton(context, completeProfileForm)
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget submitButton(BuildContext context, CompleteProfileProvider completeProfileForm) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
      ),
      onPressed: _isSaveButtonEnabled() ? () => _saveNewProfile(completeProfileForm, context) : null,
      child: const Text('Guardar', style: TextStyle(color: Colors.black),),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
      ),
      onPressed: () {
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

  bool _isSaveButtonEnabled() {
    // final completeProfileForm = Provider.of<CompleteProfileProvider>(context);
    // return completeProfileForm.isValidForm();
    return true;
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

  Future<void> _saveNewProfile(CompleteProfileProvider completeProfileForm, BuildContext context) async {
    bool formValid = context.read<CompleteProfileProvider>().isValidForm();
    // if (!formValid) return;
    if (completeProfileForm.profilePhoto == null) {
      NotificationService.showErrorDialogAlert(context, 'Debe elegir una foto de perfil');
    }
    UserProfileDto? userProfileDto = await context.read<CompleteProfileProvider>().saveProfile();
    if (userProfileDto != null) {
      // Navigator.pushReplacementNamed(context, 'add-location');
      Navigator.of(context).push(CustomPageRouter(child: const AddLocationScreen(), typeTransition: 2, axisDirection: AxisDirection.right));
      await Future.delayed(const Duration(milliseconds: 1000));
      // ignore: use_build_context_synchronously
      NotificationService.showInfoDialogAlert(
        context,
        'Bienvenido', 
        'Hola ${userProfileDto.firstName}, ahora debes completar tu ubicacion!', 
        null
      );
    } 
    // completeProfileForm.isLoading = false;
    // // Navigator.pushReplacementNamed(context, 'complete-profile');
  }

}


