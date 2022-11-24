import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/login_bloc/login_event.dart';
import 'package:travelservices/blocs/login_bloc/login_state.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/signup_model.dart';
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
      // Set local data
      SharedPreferencesCustom.setStringCustom('accessToken', auth.accessToken.toString());
      SharedPreferencesCustom.setBoolCustom('isLogined', true);
      SharedPreferencesCustom.setStringCustom('refreshToken', auth.refreshToken.toString());
      SharedPreferencesCustom.setStringCustom('username', auth.username);
      SharedPreferencesCustom.setStringCustom('email', auth.email);
      SharedPreferencesCustom.setStringCustom('phone', auth.phone);
      SharedPreferencesCustom.setBoolCustom('provider', auth.provider);
      SharedPreferencesCustom.setStringCustom('role', auth.roles[0]);
      SharedPreferencesCustom.setIntCustom('idAuth', auth.id);
      
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(status: const InitialStatus()));

      // Handle firebase
      authRepo.updateStatusUser(true, auth.id.toString());
      
    }

    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    print("==============$token");

  }

  void loginProvider(LoginByProvider event, Emitter<LoginState> emit) async {
    
    var user = await authRepo.loginWithProvider();

    var model = await authRepo.signUpRepo(
      user.email!, 
      user.email!, 
      user.phoneNumber ?? "", 
      user.uid, 
      user.displayName!, 
      "", 
      "",
      2
    );

    if (model is MessageModel) {
      emit(state.copyWith(statusProvider: 1));
    } 
    if (model is SignUpResponse) {
      emit(state.copyWith(statusProvider: 1));

      // Handle Firebase


    }

    if (state.statusProvider == 1) {
      var auth = await authRepo.loginRepo(user.email!, user.uid);
      if (auth is MessageModel) {
        emit(state.copyWith(status: FailedStatus()));
      }
      if (auth is LoginResponseModel) {
        emit(state.copyWith(status: SuccessStatus(), typeObject: auth.roles[0]));
        
        // Set local data
        SharedPreferencesCustom.setStringCustom('accessToken', auth.accessToken.toString());
        SharedPreferencesCustom.setBoolCustom('isLogined', true);
        SharedPreferencesCustom.setStringCustom('refreshToken', auth.refreshToken.toString());
        SharedPreferencesCustom.setStringCustom('username', auth.username);
        SharedPreferencesCustom.setStringCustom('email', auth.email);
        SharedPreferencesCustom.setStringCustom('phone', auth.phone);
        SharedPreferencesCustom.setBoolCustom('provider', auth.provider);
        SharedPreferencesCustom.setStringCustom('role', auth.roles[0]);
        SharedPreferencesCustom.setIntCustom('idAuth', auth.id);
        
        await Future.delayed(const Duration(seconds: 3));
        emit(state.copyWith(status: const InitialStatus()));
      }
    }
    if (state.statusProvider == -1) {
       emit(state.copyWith(status: FailedStatus()));
    }
  }
}