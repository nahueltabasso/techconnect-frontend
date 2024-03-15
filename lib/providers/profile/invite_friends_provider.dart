import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/friend_request_dto.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/services/context_service.dart';
import 'package:techconnect_frontend/services/user_profile_servide.dart';

class InviteFriendsProvider extends ChangeNotifier {
  
  List<UserProfileDto>? userProfileList = [];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    // notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  Future<List<UserProfileDto>?> getNearbyPossiblesFriends() async {
    isLoading = true;
    BuildContext? context = ContextService().context!;
    final userProfileService = Provider.of<UserProfileService>(context, listen: false);
    try {
      final userProfileId = userProfileService.loggedUserProfile?.id ?? 31;
      userProfileList = await userProfileService.getPossibleFriends(userProfileId);
      await Future.delayed(const Duration(milliseconds: 1000));
      isLoading = false;
      return userProfileList;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  Future<FriendRequestDto?> sendFriendRequest(UserProfileDto toUser) async {
    isLoading = true;
    BuildContext? context = ContextService().context!;
    final userProfileService = Provider.of<UserProfileService>(context, listen: false);
    try {
      // final fromUser = userProfileService.loggedUserProfile;
      final fromUser = await userProfileService.getUserProfileById(31);

      FriendRequestDto? friendRequestDto = FriendRequestDto(
        id: null,
        fromUser: fromUser, 
        fromEmail: fromUser.email, 
        toUser: toUser, 
        toEmail: toUser.email, 
        status: false,
        createAt: null
      );
      friendRequestDto = await userProfileService.sendFriendRequest(friendRequestDto, context);
      isLoading = false;
      return friendRequestDto;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }
}


// delete from user_locations where user_profile_id = (select id from user_users_profiles where user_id=24);
// delete from user_users_profiles where user_id = 24;
// update auth_users set first_login = true where id = 24;