import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelservices/models/cart_model.dart';
import 'package:travelservices/models/login_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/order_model.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/models/profile_model.dart';
import 'package:travelservices/models/refresh_token_model.dart';
import 'package:travelservices/models/signup_model.dart';
import 'package:travelservices/models/untils_model.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class Api {
  
  Dio dio = Dio();
  static String url = "http://192.168.1.6:8089/";
  
  Api() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 403) {
          if (await SharedPreferencesCustom.existsKey('refreshToken')) {
            if (await refreshToken()) {
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

  Future<Object> getRequestAuth(String url, String endpoint) async {
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
      return MessageModel(message: "Error 403");
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

  Future<MessageModel> postChangePassword(String url, String endPoint, ChangePasswordModel model) async {
    Response response;
    try {
      response = await Dio().post(
        url + endPoint,
        data:  model.toJson()
      );
      return MessageModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<Object> deleteFavorite (String url, String path, String id) async {
    Response response;
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      response = await dio.delete(
        url + path + id,
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return response;
    } on DioError catch (e) {
      return MessageModel(message: "Error 403");
    }
  }

  Future<Object> postFavorite(String url, String endpoint, String id) async {
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
      return response;
    } on DioError catch (e) {
      return MessageModel(message: "Error 403");
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

  Future<Object> updateProfile(ProfileRequest request, String endpoint) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    Response response;
    try {
      response = await Dio().put(
        "$url$endpoint",
        data: request.toJson(),
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return response;
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }

  Future<Object> uploadAvatar(String endPoint, File imageFile) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    Response response;
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file" : await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      });
      response = await dio.post(
        "$url$endPoint",
        data: formData,
        options:  Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
            "Content-Type" : "multipart/form-data"
          },
        ),
      );
      return response;
    } on DioError catch(e) {
      return MessageModel(message: '');
    }
  }


  // Admin
  Future<Object> uploadGalleryProduct(String endPoint, List<XFile> images) async {
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    Response response;
    try {
      var formData = FormData();
      for (var image in images) {
        formData.files.addAll([
          MapEntry("files", await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'jpeg'),
          )),
        ]);
      }
      response = await dio.post(
        "$url$endPoint",
        data: formData,
        options:  Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
            "Content-Type" : "multipart/form-data"
          },
        ),
      );
      return response;
    } on DioError catch(e) {
      return MessageModel(message: '');
    }
  }

  Future<Object> deleteGalleryProduct (String url, String path, String idLink, String publicId, String idService) async {
    Response response;
    String token = await SharedPreferencesCustom.getStringCustom('accessToken');
    try {
      FormData formData = FormData.fromMap({
        "publicId" : publicId,
        "idService" : idService
      });
      response = await dio.delete(
        url + path + idLink,
        data: formData,
        options: Options(
          headers: {
            "Accept" : "*/*",
            "Authorization" : "Bearer $token",
          },
        )
      );
      return response;
    } on DioError catch (e) {
      print("111111111111111111111111111111111111");
      return MessageModel(message: "Error 403");
    }
  }

  Future<MessageModel> postService(String url, String endpoint, CreateProduct model) async {
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
      return MessageModel.fromJson(response.data);
    } on DioError catch (e) {
      return MessageModel(message: '');
    }
  }
  
}