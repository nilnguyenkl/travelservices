import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/infor_order_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/product_admin_model.dart';
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

  Future<InforOrder> getRangeOrder(String endpoint) async {
    Response response;
    response = await api.getRequest(Api.url, endpoint);
    return InforOrder.fromJson(response.data);
  }

  Future<MessageModel> postServiceForAdmin(CreateProduct model) async {
    return await api.postService(Api.url, 'admin/service', model);
  }

  Future<ProductDetails> getProductDetailsForAdmin(String endPoint) async {
    Response response;
    response = await api.getRequest(Api.url, endPoint);
    return ProductDetails.fromJson(response.data);
  }
  
}