import 'package:flutter/material.dart';

class NotificationService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 22),),
    );
    
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showErrorDialogAlert(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.error_outline_rounded, color: Colors.red, size: 50,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text('Error', style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue)
                ),
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('Aceptar')
              ),
            ),
          ],
        );
      },
    );
  }

  static showSuccessDialogAlert(BuildContext context, String title, String message, String? route) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.check_box_outlined, color: Colors.lightBlue, size: 50,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue)
                ),
                onPressed: () => Navigator.pop(context, route),
                child: const Text('Aceptar')
              ),
            ),
          ],
        );
      },
    );
  }

  static showInfoDialogAlert(BuildContext context, String title, String message, String? route) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: const Icon(Icons.info_outline, color: Colors.lightBlue, size: 50,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: FilledButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue)
                ),
                onPressed: () => Navigator.pop(context, route),
                child: const Text('Aceptar')
              ),
            ),
          ],
        );
      },
    );
  }


}