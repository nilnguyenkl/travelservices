import 'package:travelservices/models/order_model.dart';

class OrderArguments {
  
  final bool statusOrder;
  final List<ItemsTicket> items;
  
  final String nameProduct;
  final String description;
  final int minPrice;

  OrderArguments({
    required this.statusOrder,
    required this.items,
    required this.nameProduct,
    required this.description,
    required this.minPrice
  });

}
