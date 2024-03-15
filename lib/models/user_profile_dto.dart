import 'dart:convert';

import 'package:intl/intl.dart';

class UserProfileDto {
  
    int? id;
    String firstName;
    String lastName;
    String email;
    dynamic phoneNumber;
    String? profilePhoto;
    DateTime birthDate;
    bool verifiedProfile;
    dynamic personalStatus;
    dynamic studies;
    String? biography;
    int userId;
    bool? activeProfile;

    UserProfileDto({
        this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        this.profilePhoto,
        required this.birthDate,
        required this.verifiedProfile,
        required this.personalStatus,
        required this.studies,
        this.biography,
        required this.userId,
        this.activeProfile,
    });

    factory UserProfileDto.fromRawJson(String str) => UserProfileDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserProfileDto.fromJson(Map<String, dynamic> json) => UserProfileDto(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profilePhoto: json["profilePhoto"],
        birthDate: DateTime.parse(json["birthDate"]),
        verifiedProfile: json["verifiedProfile"],
        personalStatus: json["personalStatus"],
        studies: json["studies"],
        biography: json["biography"],
        userId: json["userId"],
        activeProfile: json["activeProfile"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePhoto": profilePhoto,
        "birthDate": DateFormat('yyyy-MM-ddTHH:mm:ss').format(birthDate),
        "verifiedProfile": verifiedProfile,
        "personalStatus": personalStatus,
        "studies": studies,
        "biography": biography,
        "userId": userId,
        "activeProfile": activeProfile,
    };
}
