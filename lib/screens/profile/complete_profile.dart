import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/services/auth_service.dart';

class CompleteProfileScreen extends StatefulWidget {
   
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  int activeStep = 0;
  int upperBound = 3;

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

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
        child: Column(
          children: [
            IconStepper(
              icons: const [
                Icon(Icons.person_4_rounded),
                Icon(Icons.school_outlined),
                Icon(Icons.photo_camera),
                Icon(Icons.location_city)
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
            
            Expanded(
              child: FittedBox(
                child: Center(
                  child: Text('$activeStep'),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                previousButton(),
                nextButton()
              ],
            )
          ],
        ),
      )
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
      ),
      onPressed: () {
        print("ENTRA");
        if (activeStep == upperBound) {
          print("En este momento hay que ir al endpoint");
        }
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
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
        return 'Introduction';
    }
  }


}


