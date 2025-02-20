class ResetPasswordRequest {
  final String email;
  final String password;
  final String passwordConfirmation;
  final String token;

  ResetPasswordRequest({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'token': token,
    };
  }
}
