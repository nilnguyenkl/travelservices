import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_event.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/repositories/cart_repositories.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartRepository cartRepo = CartRepository();

  CartBloc() : super(CartState.empty()) {
    on<CartReadEvent>(onCartRead);
    on<CartAddEvent>(onCartAdd);
    on<CartUpdateEvent>(onCartUpdate);
    on<CartDeleteEvent>(onCartDelete);
  }

  void onCartRead(CartReadEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await cartRepo.getCart("cart?page=1&limit=99&sort=ASC");
    emit(state.copyWith(items: data, getLoading: false));
  }

  void onCartAdd(CartAddEvent event, Emitter<CartState> emit) {
  
  }

  void onCartUpdate(CartUpdateEvent event, Emitter<CartState> emit) {
  
  }

  void onCartDelete(CartDeleteEvent event, Emitter<CartState> emit) {
  
  }
}