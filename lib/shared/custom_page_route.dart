import 'package:flutter/material.dart';

class CustomPageRouter extends PageRouteBuilder {
  
  final Widget child;
  final int typeTransition;
  final AxisDirection? axisDirection;

  CustomPageRouter({
    required this.child,
    required this.typeTransition,
    this.axisDirection
  }) : super(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => child
  );


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
                          Animation<double> secondaryAnimation, Widget child) {

    // typeTransition = 1 -> page transition left to right
    if (typeTransition == 1) {
      return SlideTransition (
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end:  Offset.zero,
          ).animate(animation),
        child: child,
      );
    } 

    // typeTransition = 2 -> transition with axis directorion (up, down, right, left)
    if (typeTransition == 2) {
      return SlideTransition (
        position: Tween<Offset>(
          begin: getBeginOffSet(),
          end:  Offset.zero,
          ).animate(animation),
        child: child,
      );
    }

    // defaultTransition
    return SlideTransition (
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end:  Offset.zero,
        ).animate(animation),
      child: child,
      );

  }

  Offset getBeginOffSet() {
    switch (axisDirection!) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }


}