import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/infor_order_model.dart';
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

  Future<List<EventCalender>> getListEvent(String endPoint) async {
    Response response;
    response = await api.getRequestAuth(Api.url, endPoint);
    return (response.data as List).map((e) => EventCalender.fromJson(e)).toList();
  }

  Future<User> loginWithProvider() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user!;
  }

} 