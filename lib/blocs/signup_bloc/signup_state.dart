import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  
  final String username;
  final String? errorUsername;

  final String email;
  final String? errorEmail;

  final String phone;
  final String? errorPhone;

  final String firstname;
  final String lastname;
  final String gender;
  final String password;
  final String cnfpassword;

  final bool eyePassword;
  final bool eyeCnfPassword;

  final SubmitStatus status;



  const SignUpState({
    this.errorUsername,
    this.errorEmail,
    this.errorPhone,
    this.username = '',
    this.email = '',
    this.phone = '', 
    this.firstname = '',
    this.lastname = '',
    this.gender = 'Male',
    this.cnfpassword = '', 
    this.password = '',
    this.eyePassword = false,
    this.eyeCnfPassword = false,
    this.status = const InitialStatus()
  });

  SignUpState copyWith({
    String? errorUsername,
    String? errorEmail,
    String? errorPhone,
    String? username,
    String? email,
    String? phone,
    String? firstname,
    String? lastname,
    String? gender,
    String? password,
    String? cnfpassword,
    bool? eyePassword,
    bool? eyeCnfPassword,
    SubmitStatus? status,
  }) {
    return SignUpState(
      errorUsername: errorUsername ?? this.errorUsername,
      errorEmail: errorEmail ?? this.errorEmail,
      errorPhone: errorPhone ?? this.errorPhone,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      cnfpassword: cnfpassword ?? this.cnfpassword,
      eyePassword: eyePassword ?? this.eyePassword,
      eyeCnfPassword: eyeCnfPassword ?? this.eyeCnfPassword,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object?> get props => [
    errorUsername,
    errorEmail,
    errorPhone,
    gender, 
    eyePassword, 
    eyeCnfPassword, 
    username, 
    email,
    phone,
    firstname,
    lastname,
    password,
    status
  ];
  
}


class SubmitStatus {
  const SubmitStatus();
}

class InitialStatus extends SubmitStatus {
  const InitialStatus();
}

class SubmittingStatus extends SubmitStatus {}

class SuccessStatus extends SubmitStatus {}

class FailedStatus extends SubmitStatus {}

