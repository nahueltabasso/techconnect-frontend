import 'dart:convert';

class HttpErrorDto {
    int? httpStatus;
    DateTime? timestamp;
    String? errorCode;
    String message;
    String? description;

    HttpErrorDto({
      this.httpStatus,
      this.timestamp,
      this.errorCode,
      required this.message,
      this.description,
    });

    factory HttpErrorDto.fromRawJson(String str) => HttpErrorDto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HttpErrorDto.fromJson(Map<String, dynamic> json) => HttpErrorDto(
        httpStatus: json["httpStatus"],
        timestamp: DateTime.parse(json["timestamp"]),
        errorCode: json["errorCode"],
        message: json["message"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "httpStatus": httpStatus,
        "timestamp": timestamp!.toIso8601String(),
        "errorCode": errorCode,
        "message": message,
        "description": description,
    };
}
