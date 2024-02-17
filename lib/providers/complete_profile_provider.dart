import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/services/auth_service.dart';
import 'package:techconnect_frontend/services/context_service.dart';
import 'package:techconnect_frontend/services/user_profile_servide.dart';

class CompleteProfileProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  DateTime birthDate = DateTime.now();
  String studies = '';
  String biography = '';
  String personalStatus = 'Soltero/a';
  File? profilePhoto = null;
  
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print("End valid form");
    return formKey.currentState?.validate() ?? false;
  }

  Future<UserProfileDto?> saveProfile() async {
    isLoading = true;
    BuildContext? context = ContextService().context!;
    final userProfileService = Provider.of<UserProfileService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    final Map<String, dynamic> userProfileData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toString(),
      'verifiedProfile': false,
      'personalStatus': personalStatus,
      'studies': studies,
      'biography': biography,
      'userId': authService.userDto!.id,
      'activeProfile': true
    };

    File photo = profilePhoto!;
    try {
      UserProfileDto? userProfileDto = await userProfileService.saveProfile(userProfileData, photo, context);
      isLoading = false;
      return userProfileDto;
    } catch (e) {
      // ignore: avoid_print
      print(e);    
    }
    isLoading = false;
    return null;
  }
}