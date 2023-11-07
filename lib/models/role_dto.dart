import 'dart:convert';

class Role {
    dynamic id;
    String roleName;

    Role({
        required this.id,
        required this.roleName,
    });

    factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleName: json["roleName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
    };
}
