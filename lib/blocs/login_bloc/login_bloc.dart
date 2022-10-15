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
      print("1");  
    }
    if (auth is LoginResponseModel) {
      emit(state.copyWith(status: SuccessStatus()));
      SharedPreferencesCustom.setStringCustom('accessToken', auth.accessToken.toString());
      print("2");
    }
  }
}