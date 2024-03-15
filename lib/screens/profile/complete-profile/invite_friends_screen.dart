import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';
import 'package:techconnect_frontend/providers/profile/invite_friends_provider.dart';
import 'package:techconnect_frontend/screens/home_screen.dart';
import 'package:techconnect_frontend/shared/custom_page_route.dart';
import 'package:techconnect_frontend/shared/loading_screen.dart';
import 'package:techconnect_frontend/widgets/invite_friend_card.dart';


class InviteFriendsScreen extends StatelessWidget {

  static const String routeName = 'invite-friends';
  static const String screenTitle = 'Invita a amigos';
  int userProfileId;

  InviteFriendsScreen({super.key, required this.userProfileId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(screenTitle)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<InviteFriendsProvider>(context, listen: false).getNearbyPossiblesFriends(),
            builder: (context, AsyncSnapshot<List<UserProfileDto>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (Provider.of<InviteFriendsProvider>(context, listen: false).isLoading) {
                return const LoadingScreen(titleAppBar: screenTitle);
              }

              final userProfileList = snapshot.data;
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: ListView.builder(
                      itemCount: userProfileList?.length ?? 0,
                      itemBuilder: (context, index) => InviteFriendCard(userProfileDto: userProfileList![index]),
                    ),
                  ),


                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Skip Button
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              CustomPageRouter(child: const HomeScreen(), typeTransition: 2, axisDirection: AxisDirection.right)
                            ),
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey)),
                            child: const Text('Omitir', style: TextStyle(color: Colors.black)),
                          ),

                          // Finish Button
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              CustomPageRouter(child: const HomeScreen(), typeTransition: 2, axisDirection: AxisDirection.right)
                            ),  
                            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue)),
                            child: const Text('Finalizar', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

        ],
      ),
    );
  }
}