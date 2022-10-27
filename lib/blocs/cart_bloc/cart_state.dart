import 'package:equatable/equatable.dart';
import 'package:travelservices/models/cart_model.dart';

class CartState extends Equatable {
  
  final bool getLoading;
  final List<CartResponseModel> items;
  
  final bool statusCreate;

  final bool statusUpdate;

  final bool statusDelete;

  const CartState({
    required this.getLoading,
    required this.items,
    required this.statusCreate,
    required this.statusDelete,
    required this.statusUpdate
  });

  factory CartState.empty() {
    return const CartState(
      getLoading: false, 
      items: <CartResponseModel>[], 
      statusCreate: false, 
      statusDelete: false, 
      statusUpdate: false
    );
  }

  CartState copyWith({
    bool? getLoading,
    List<CartResponseModel>? items,
    bool? statusCreate,
    bool? statusDelete,
    bool? statusUpdate
  }) {
    return CartState(
      getLoading: getLoading ?? this.getLoading, 
      items: items ?? this.items, 
      statusCreate: statusCreate ?? this.statusCreate, 
      statusDelete: statusDelete ?? this.statusDelete, 
      statusUpdate: statusUpdate ?? this.statusUpdate
    );
  }

  @override
  List<Object?> get props => [getLoading, items, statusCreate, statusDelete, statusUpdate];

}