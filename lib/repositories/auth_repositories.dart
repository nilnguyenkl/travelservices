import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/signup_model.dart';

class AuthRepository {
  Api api = Api();

  Future<MessageModel> signUpRepo(String username, String email, String phone, String password, String lastname, String firstname, String gender, int idRole) {
    SignUpRequest request = SignUpRequest(username, email, phone, password, lastname, firstname, gender, idRole); 
    return api.postSignUp(Api.url, "auth/register", request);
  }

  Future<Object> loginRepo(String username, String password) {
    LoginRequestModel request = LoginRequestModel(username: username, password: password);
    return api.postLogin(Api.url, "auth/login", request);
  }

} 