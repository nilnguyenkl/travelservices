import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/repositories/product_repositories.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  ProductRepository productRepo = ProductRepository();
  AdminProductBloc() : super(AdminProductState.empty()) {
    on<AdminSelectMultipleImageEvent>(onSelectImages);
    on<AdminUnSelectMultipleImageEvent>(onUnSelectImages);
  }

  void onUnSelectImages(AdminUnSelectMultipleImageEvent event, Emitter<AdminProductState> emit) {
    
  }

  void onSelectImages(AdminSelectMultipleImageEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(images: event.images));
    print(state.images[0].path);
  }
}