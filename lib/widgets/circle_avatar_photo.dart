import 'package:flutter/material.dart';

class CircleAvatarPhoto extends StatelessWidget {

  final String imagePath;
  final double radius;

  const CircleAvatarPhoto({
    super.key,
    required this.imagePath, required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: radius,
        // child: Icon(Icons.person),
        child: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}