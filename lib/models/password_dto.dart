import 'dart:convert';

class PasswordDTO {

    String code;
    String newPassword;
    String confirmPassword;

    PasswordDTO({
      required this.code,
      required this.newPassword,
      required this.confirmPassword
    });

    String toRawJson() => json.encode(toJson());

    Map<String, dynamic> toJson() => {
        "code": code,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
    };
}