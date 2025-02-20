class SignupRequest {
  final String name;

  final String email;

  SignupRequest({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}

class SignupModel {
  SignupModel({
    this.message,
    this.email,
  });

  SignupModel.fromJson(dynamic json) {
    message = json['message'];
    email = json['email'];
  }

  String? message;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['email'] = email;
    return map;
  }
}

class VerifyOtpRequest {
  final String email;
  final String otp;

  VerifyOtpRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}

class SetPasswordRequest {
  final String email;
  final String password;
  final String password_confirmation;

  SetPasswordRequest({required this.email,required this.password,required this.password_confirmation,});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }
}
