import 'package:equatable/equatable.dart';
import 'package:travelservices/models/cart_model.dart';

class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartReadEvent extends CartEvent {
  CartReadEvent();
}

class CartAddEvent extends CartEvent {
  final CartRequestModel data;
  CartAddEvent({
    required this.data
  });
}

class CartUpdateEvent extends CartEvent {
  final int idCartItem;
  final CartRequestModel data;
  CartUpdateEvent({
    required this.idCartItem,
    required this.data
  });
}

class CartDeleteEvent extends CartEvent {
  final int idCartItem;
  CartDeleteEvent({
    required this.idCartItem
  });
}

