import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/order_model.dart';

class OrderRepository {
  Api api = Api();

  Future<Object> createOrder(OrderRequestModel requestModel) async {
    return await api.postOrder(Api.url, "order", requestModel);
  }
}