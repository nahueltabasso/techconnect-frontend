import 'dart:convert';

import 'package:techconnect_frontend/models/user_profile_dto.dart';

class FriendRequestDto {

    int? id;
    UserProfileDto fromUser;
    String fromEmail;
    UserProfileDto toUser;
    String toEmail;
    bool status;
    DateTime? createAt;

    FriendRequestDto({
        this.id,
        required this.fromUser,
        required this.fromEmail,
        required this.toUser,
        required this.toEmail,
        required this.status,
        this.createAt,
    });

    factory FriendRequestDto.fromRawJson(String str) => FriendRequestDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FriendRequestDto.fromJson(Map<String, dynamic> json) => FriendRequestDto(
        id: json["id"],
        fromUser: UserProfileDto.fromJson(json["fromUser"]),
        fromEmail: json["fromEmail"],
        toUser: UserProfileDto.fromJson(json["toUser"]),
        toEmail: json["toEmail"],
        status: json["status"],
        createAt: DateTime.parse(json["createAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fromUser": fromUser.toJson(),
        "fromEmail": fromEmail,
        "toUser": toUser.toJson(),
        "toEmail": toEmail,
        "status": status,
    };

}

