import 'dart:convert';

class NewUserDto {
    String username;
    String email;
    String password;
    String confirmPassword;
    bool googleUser;
    bool facebookUser;
    bool appleUser;
    bool firstLogin;
    dynamic roles;
    bool userLocked;
    int failsAttemps;

    NewUserDto({
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
        required this.googleUser,
        required this.facebookUser,
        required this.appleUser,
        required this.firstLogin,
        required this.roles,
        required this.userLocked,
        required this.failsAttemps,
    });

    factory NewUserDto.fromRawJson(String str) => NewUserDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NewUserDto.fromJson(Map<String, dynamic> json) => NewUserDto(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        googleUser: json["googleUser"],
        facebookUser: json["facebookUser"],
        appleUser: json["appleUser"],
        firstLogin: json["firstLogin"],
        roles: json["roles"],
        userLocked: json["userLocked"],
        failsAttemps: json["failsAttemps"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "googleUser": googleUser,
        "facebookUser": facebookUser,
        "appleUser": appleUser,
        "firstLogin": firstLogin,
        "roles": roles,
        "userLocked": userLocked,
        "failsAttemps": failsAttemps,
    };
}
