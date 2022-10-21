import 'package:dio/dio.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/signup_model.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class Api {
  final Dio _dio = Dio();
  static String url = "http://192.168.1.8:8089/";

  Future<Response> getRequest(String url, String endpoint) async {
    Response response;
    try {
      response = await _dio.get(url + endpoint);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> getRequestAuth(String url, String endpoint) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    Response response;
    try {
      response = await _dio.get(
        url + endpoint,
        options:  Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        ),
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response; 
  }

  Future<Object> postLogin(String url, String endpoint, LoginRequestModel request) async {
    Response response;
    try {
      response = await Dio().post(
        url + endpoint,
        data:  request.toJson()
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<MessageModel> postSignUp(String url, String endpoint, SignUpRequest request) async {
    Response response;
    try {
      response = await Dio().post(
        url + endpoint,
        data:  request.toJson()
      );
      return MessageModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<void> deleteFavorite (String url, String path, String id) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      await _dio.delete(
        url + path + id,
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<MessageModel> postFavorite(String url, String endpoint, String id) async {
    Response response;
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      response = await Dio().post(
        url + endpoint + id,
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return MessageModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }



}