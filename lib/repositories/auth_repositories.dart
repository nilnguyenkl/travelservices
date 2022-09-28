import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/signup_model.dart';

class AuthRepository {
  Api api = Api();

  Future<MessageModel> signUpRepo(String username, String email, String phone, String password, String lastname, String firstname, String gender, int idRole) {
    SignUpRequest request = SignUpRequest(username, email, phone, password, lastname, firstname, gender, idRole); 
    return api.postSignUp(Api.url, "auth/register", request);
  }
  
} 