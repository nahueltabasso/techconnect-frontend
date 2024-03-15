import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UsernameText extends StatelessWidget {

  final String username;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final double fontSize;
  int? userProfileId;

  UsernameText({
    super.key, 
    required this.username, 
    required this.color, 
    required this.fontStyle, 
    required this.fontWeight, 
    required this.fontSize,
    this.userProfileId
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Text(
  //     '${userProfileDto.firstName} ${userProfileDto.lastName}',
  //     style: const TextStyle(color: Colors.lightBlue, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold, fontSize: 16),
  //   );

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: TextStyle(
        color: color, 
        fontStyle: fontStyle, 
        fontWeight: fontWeight, 
        fontSize: fontSize
      ),
    );

  }
}  