import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/login_bloc/login_event.dart';
import 'package:travelservices/blocs/login_bloc/login_state.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/repositories/auth_repositories.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState.empty()) {
    on<LoginUsernameEvent>(loginUsername);
    on<LoginPasswordEvent>(loginPassword);
    on<LoginEyePasswordEvent>(loginEyePassword);
    on<LoginSubmitEvent>(loginSubmit);
    on<LoginByProvider>(loginProvider);
  }


  void loginUsername(LoginUsernameEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void loginPassword(LoginPasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void loginEyePassword(LoginEyePasswordEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(eyeStatus: event.eyeStatus));
  }

  void loginSubmit(LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: SubmittingStatus()));
    var auth = await authRepo.loginRepo(state.username, state.password);
    if (auth is MessageModel) {
      emit(state.copyWith(status: FailedStatus()));
    }
    if (auth is LoginResponseModel) {
      emit(state.copyWith(status: SuccessStatus(), typeObject: auth.roles[0]));
      SharedPreferencesCustom.setStringCustom('accessToken', auth.accessToken.toString());
      SharedPreferencesCustom.setBoolCustom('isLogined', true);
      SharedPreferencesCustom.setStringCustom('refreshToken', auth.refreshToken.toString());
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(status: const InitialStatus()));
    }
  }

  void loginProvider(LoginByProvider event, Emitter<LoginState> emit) async {
    
    var user = await authRepo.loginWithProvider();

    await authRepo.signUpRepo(
      user.email!, 
      user.email!, 
      user.phoneNumber ?? "", 
      user.uid, 
      user.displayName!, 
      "", 
      "",
      2
    ).then((value){
      switch (value.message) {
        case "Username already exists":
          emit(state.copyWith(statusProvider: 1));
          break;
        case "Success":
          emit(state.copyWith(statusProvider: 1));
          break;
      }
    });

    if (state.statusProvider == 1) {
      var auth = await authRepo.loginRepo(user.email!, user.uid);
      if (auth is MessageModel) {
        emit(state.copyWith(status: FailedStatus()));
      }
      if (auth is LoginResponseModel) {
        emit(state.copyWith(status: SuccessStatus(), typeObject: auth.roles[0]));
        SharedPreferencesCustom.setStringCustom('accessToken', auth.accessToken.toString());
        SharedPreferencesCustom.setBoolCustom('isLogined', true);
        SharedPreferencesCustom.setStringCustom('refreshToken', auth.refreshToken.toString());
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(status: const InitialStatus()));
      }
    }
    if (state.statusProvider == -1) {
       emit(state.copyWith(status: FailedStatus()));
    }
  }
}