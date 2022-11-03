import 'package:dio/dio.dart';
import 'package:travelservices/models/cart_model.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/models/refresh_token_model.dart';
import 'package:travelservices/models/signup_model.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class Api {
  
  Dio dio = Dio();
  static String url = "http://192.168.1.66:8089/";
  
  
  Api() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 403) {
          if (await SharedPreferencesCustom.existsKey('refreshToken')) {
            if (await refreshToken()) {
              print("1111111111111111");
              return handler.resolve(await _retry(error.requestOptions));
            }
          }
        }
        return handler.next(error);
      }
    ));
  }
  
  
  
  static Future<String> getTokenAccess() async {
    return await SharedPreferencesCustom.getStringCustom('accessToken');
  }

  static Future<bool> getTokenLogin() async {
    return await SharedPreferencesCustom.getBoolCustom('isLogined');
  }

  

  Future<bool> refreshToken() async {
    final refreshToken = await SharedPreferencesCustom.getStringCustom('refreshToken');
    Response response;
    try {
      response = await dio.post(
        'auth/refreshtoken',
        data: {
          'refreshToken' : refreshToken
        }
      );

      print(refreshToken);
      
      SharedPreferencesCustom.setStringCustom("accessToken", RefreshTokenModel.fromJson(response.data).accessToken);
      SharedPreferencesCustom.setStringCustom("refreshToken", RefreshTokenModel.fromJson(response.data).refreshToken);

      return true;
      
    } on DioError catch (e) {
      return false;
    }
    
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options
    );
  }

  Future<Response> getRequest(String url, String endpoint) async {
    Response response;
    try {
      response = await dio.get(url + endpoint);
    } on DioError catch (e) {

      throw Exception(e.message);
    }
    return response;
  }

  Future<Response> getRequestAuth(String url, String endpoint) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    Response response;
    try {
      response = await dio.get(
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

  Future<Object> postSignUp(String url, String endpoint, SignUpRequest request) async {
    Response response;
    try {
      response = await Dio().post(
        url + endpoint,
        data:  request.toJson()
      );
      if (response.data['status'].toString() == "Success") {
        return SignUpResponse.fromJson(response.data['data']);
      } else {
        return MessageModel.fromJson(response.data['data']);
      }
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<void> deleteFavorite (String url, String path, String id) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      await dio.delete(
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

  Future<Object> postOrder(String url, String endpoint, OrderRequestModel model) async {
    Response response;
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      response = await Dio().post(
        url + endpoint,
        data: model.toJson(),
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return OrderResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<Object> postCart(String url, String endpoint, CartRequestModel model) async {
    Response response;
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      response = await Dio().post(
        url + endpoint,
        data: model.toJson(),
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return CartResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<Object> putCart(String url, String endpoint, int id, CartRequestModel model) async {
    Response response;
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      response = await Dio().put(
        "$url$endpoint/$id",
        data: model.toJson(),
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return CartResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<void> deleteCartItem (String url, String path, String id) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      await dio.delete(
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
  
}