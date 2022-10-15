import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/favorite_model.dart';
import 'package:travelservices/models/message_model.dart';

class FavoriteRepository {
  
  Api api = Api();

  Future<List<FavoriteResponseModel>> getListFavorite(String endPoint) async {
    Response response;
    response = await api.getRequestAuth(Api.url, endPoint);
    return (response.data as List).map((e) => FavoriteResponseModel.fromJson(e)).toList();
  }

  Future<MessageModel> insertFavorite(String endPoint, String id) async {
    return await api.postFavorite(Api.url, endPoint, id);
  }
  
}