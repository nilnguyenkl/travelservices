import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool eyeStatus;
  final SubmitStatus status;


  const LoginState({
    required this.username,
    required this.password,
    required this.eyeStatus,
    required this.status
  });

  factory LoginState.empty() {
    return const LoginState(
      username: "", 
      password: "", 
      eyeStatus: false, 
      status: InitialStatus()
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    bool? eyeStatus,
    SubmitStatus? status
  }) {
    return LoginState(
      username: username ?? this.username, 
      password: password ?? this.password, 
      eyeStatus: eyeStatus ?? this.eyeStatus,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object?> get props => [username, password, eyeStatus, status];
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