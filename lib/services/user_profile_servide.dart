import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:techconnect_frontend/models/user_profile_dto.dart';


class UserProfileService extends ChangeNotifier {

  final String _baseUrl = '192.168.144.1:8090';
  final storage = FlutterSecureStorage();

  Future<UserProfileDto?> saveProfile(Map<String, dynamic> userProfileFormData, File image) async {
    // Crear una solicitud multipart para enviar el archivo
    // Create a multipart request to send a file and data
    var request = http.MultipartRequest('POST',
      Uri.parse('http://${_baseUrl}/api/users/user-profile/add'));
    // Set Authorization header
    request.headers['Authorization'] = 'Bearer ${await storage.read(key: 'accessToken')}'; // Reemplaza con tu token de acceso
    // Set data to request's form data
    request = jsonToFormData(request, userProfileFormData);
    print('requests fields ${request.fields}');

    // Set image to request
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
    }

    try {
      final response = await request.send();

      final jsonResponse = await response.stream.bytesToString();
      // final decodedData = json.decode(jsonResponse);

      if (response.statusCode == 201) {
        // La solicitud fue exitosa, puedes manejar la respuesta del backend aquí
        print('Respuesta del servidor: ${response.statusCode}');
        print(jsonResponse);
      } else {
        // La solicitud falló, maneja el error aquí
        print('Error en la solicitud: ${response.statusCode}');
        print(jsonResponse);
      }
      return null;
    } catch (e) {
      print('Error al enviar la solicitud: $e');
      return null;
    }

  }

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

}



