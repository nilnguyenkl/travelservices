import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/cart_model.dart';

class CartRepository {
  Api api = Api();

  Future<Object> createCart(CartRequestModel model) async {
    return await api.postCart(Api.url, "cart", model);
  }

  Future<Object> updateCart(CartRequestModel model, int id) async {
    return await api.putCart(Api.url, "cart", id, model);
  }

  Future<List<CartResponseModel>> getCart(String enpoint) async {
    Response response;
    response = await api.getRequestAuth(Api.url, enpoint);
    return (response.data['data'] as List).map((e) => CartResponseModel.fromJson(e)).toList();
  } 
}