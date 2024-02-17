import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techconnect_frontend/providers/profile/complete_profile_provider.dart';

class UploadProfilePhotoForm extends StatefulWidget {

  final CompleteProfileProvider completeProfileForm;
  
  const UploadProfilePhotoForm({super.key, required this.completeProfileForm});

  @override
  State<UploadProfilePhotoForm> createState() => _UploadProfilePhotoFormState();
}

class _UploadProfilePhotoFormState extends State<UploadProfilePhotoForm> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.completeProfileForm.profilePhoto = _image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_image != null)
          CircleAvatar(
            radius: 100,
            backgroundImage: FileImage(_image!),
            backgroundColor: Colors.grey,
          )
        else
          const CircleAvatar(
            radius: 100,
            child: Icon(Icons.person),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
          ),
          child: const Text('Abrir galería', style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.camera),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue)
          ),
          child: const Text('Abrir Camara',style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

}