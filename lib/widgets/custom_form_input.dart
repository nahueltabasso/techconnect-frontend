import 'package:flutter/material.dart';
import 'package:techconnect_frontend/ui/input_decorations.dart';

class CustomFormInput extends StatelessWidget {

  final ValueChanged<String>? onChanged;

  const CustomFormInput({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        decoration: InputDecorations.authInputDecoration(
          hintText: "Nombre", 
          labelText: "Juan",
          prefixIcon: Icons.person
        ),
        onChanged: (value) => onChanged!(value),
      ),
    );
  }
}