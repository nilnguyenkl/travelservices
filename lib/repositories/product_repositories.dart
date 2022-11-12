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

  Future<List<ProductShow>> getListProductForAdmin(String endpoint) async {
    var object = await api.getRequestAuth(Api.url, endpoint);
    if (object is Response) {
      return (object.data as List).map((e) => ProductShow.fromJson(e)).toList();
    } else {
      return <ProductShow>[];
    }
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

  Future<MessageModel> deleteImageProduct(String endPoint, String id, String publicId) async {
    var object = await api.deleteGalleryProduct(Api.url, endPoint, id, publicId);
    if (object is Response) {
      if (object.data == "Success") {
        return MessageModel(message: "Success");
      } else {
        return MessageModel(message: "Failed");
      }
    } else {
      return MessageModel(message: "Error 403");
    }
  }
  
}