import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/providers/profile/invite_friends_provider.dart';
import 'package:techconnect_frontend/services/notification_service.dart';
import 'package:techconnect_frontend/widgets/circle_avatar_photo.dart';
import 'package:techconnect_frontend/widgets/username_text.dart';

class InviteFriendCard extends StatelessWidget {

  final UserProfileDto userProfileDto;
  bool? flagButton = true;

  InviteFriendCard({super.key, required this.userProfileDto}) {
    flagButton = true;
  }

  void _inviteFriend(BuildContext context, InviteFriendsProvider provider) async {
    print("Entra");
    final friendRequestDto = await provider.sendFriendRequest(userProfileDto);
    if (friendRequestDto != null) {
      final msg = 'La solicitud de amistad a ${friendRequestDto.toUser.firstName} se ha enviado correctamente';
      NotificationService.showInfoDialogAlert(context, 'Solicitud enviada!', msg, null);
      flagButton = false;
      provider.notify();
    }
  }

  @override
  Widget build(BuildContext context) {

    final inviteFriendProvider = Provider.of<InviteFriendsProvider>(context);
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatarPhoto(imagePath: userProfileDto.profilePhoto!)
              ),
        
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 8, bottom: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UsernameText(
                      username: '${userProfileDto.firstName} ${userProfileDto.lastName}',
                      color: Colors.lightBlue,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Envia una solicitud a ${userProfileDto.firstName}',
                      style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
        
              const Spacer(),
        
              Padding(
                padding: const EdgeInsets.only(top: 13, bottom: 21),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.lightBlue
                  ),
                  onPressed: flagButton != true ? null : () => _inviteFriend(context, inviteFriendProvider),
                  child: flagButton == true ? const Text('Enviar solicitud') : const Text('Solicitud enviada'),
                ),
              ),
        
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey)          
      ],
    );
  }
}


