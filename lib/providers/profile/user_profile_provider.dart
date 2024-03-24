import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/services/context_service.dart';
import 'package:techconnect_frontend/services/user_profile_servide.dart';

class UserProfileProvider extends ChangeNotifier {

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadLoggedUserProfile() async {
    BuildContext? context = ContextService().context!;
    final userProfileService = Provider.of<UserProfileService>(context, listen: false);
    await userProfileService.getUserProfileLogged();
    notifyListeners();
  }

  UserProfileDto? getLoggedUserProfile() {
    BuildContext? context = ContextService().context!;
    final userProfileService = Provider.of<UserProfileService>(context, listen: false);
    final userProfileDto = userProfileService.loggedUserProfile;
    if (userProfileDto != null) {
      return userProfileDto;
    }
    return null;
  }
}