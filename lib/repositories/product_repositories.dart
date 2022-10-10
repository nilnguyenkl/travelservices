import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/product_details_model.dart';
import 'package:travelservices/models/product_model.dart';

class ProductRepository {
  
  Api api = Api();

  Future<List<ProductData>> getListProduct(String endPoint) async {
    Response response;
    response = await api.getRequest(Api.url, endPoint);
    return (response.data['items'] as List).map((e) => ProductData.fromJson(e)).toList();
  }

  Future<ProductDetailsModel> getProductDetails(String endpoint) async {
    Response response;
    response = await api.getRequest(Api.url, endpoint);
    return ProductDetailsModel.fromJson(response.data);
  }
  
}