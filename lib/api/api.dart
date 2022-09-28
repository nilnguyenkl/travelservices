import 'package:dio/dio.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/signup_model.dart';

class Api {
  final Dio _dio = Dio();
  static String url = "http://192.168.1.5:8087/";

  Future<Response> getRequest(String url, String path, bool authorization) async {
    Response response;
    try {
      response = await _dio.get(url + path);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }

  Future<MessageModel> postSignUp(String url, String endpoint, SignUpRequest request) async {
    Response response;
    print(request.toJson());
    try {
      response = await Dio().post(
        url + endpoint,
        data:  request.toJson()
      );
      return MessageModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.toString());
      return MessageModel(message: '');
    }
  }

}