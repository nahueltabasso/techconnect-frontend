import 'dart:convert';

import 'package:techconnect_frontend/models/user_profile_dto.dart';

class LocationDto {
    int? id;
    String city;
    String state;
    String country;
    String postalCode;
    String address;
    double latitude;
    double longitude;
    UserProfileDto userProfileDTO;
    Coordinate? coordinate;

    LocationDto({
        this.id,
        required this.city,
        required this.state,
        required this.country,
        required this.postalCode,
        required this.address,
        required this.latitude,
        required this.longitude,
        required this.userProfileDTO,
        this.coordinate,
    });

    factory LocationDto.fromRawJson(String str) => LocationDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationDto.fromJson(Map<String, dynamic> json) => LocationDto(
        id: json["id"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        address: json["address"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        userProfileDTO: UserProfileDto.fromJson(json["userProfileDTO"]),
        coordinate: Coordinate.fromJson(json["coordinate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "userProfileDTO": userProfileDTO.toJson(),
        "coordinate": coordinate?.toJson(),
    };
}

class Coordinate {
    double latitude;
    double longitude;

    Coordinate({
        required this.latitude,
        required this.longitude,
    });

    factory Coordinate.fromRawJson(String str) => Coordinate.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
