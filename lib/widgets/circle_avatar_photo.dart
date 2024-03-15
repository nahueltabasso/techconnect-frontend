import 'package:flutter/material.dart';

class CircleAvatarPhoto extends StatelessWidget {

  final String imagePath;

  const CircleAvatarPhoto({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: 30,
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