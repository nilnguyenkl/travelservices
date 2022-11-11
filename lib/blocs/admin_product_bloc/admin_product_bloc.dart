import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_event.dart';
import 'package:travelservices/blocs/admin_product_bloc/admin_product_state.dart';
import 'package:travelservices/repositories/product_repositories.dart';
import 'package:travelservices/screens/widgets/dynamic_schedule_widget.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  ProductRepository productRepo = ProductRepository();
  AdminProductBloc() : super(AdminProductState.empty()) {

    on<AdminAddProductEvent>(onAddProduct);
    on<AdminProductDetailsEvent>(onProductDetails);

    on<AdminCurrentIndexProductEvent>(onCurrentIndexProduct);
    on<AdminIdAreaEvent>(onIdAreaProduct);
    on<AdminIdCategoryEvent>(onIdCategoryProduct);
    
    on<AdminSelectMultipleImageEvent>(onSelectImages);
    on<AdminUnSelectMultipleImageEvent>(onUnSelectImages);

    on<AdminAddDynamicTicketProductEvent>(onAddDynamicTicketProduct);
    on<AdminAddDynamicScheduleProductEvent>(onAddDynamicScheduleProduct);
  }

  void onAddProduct(AdminAddProductEvent event, Emitter<AdminProductState> emit) async {
    var data = await productRepo.postServiceForAdmin(event.product);
    if (data.message.isEmpty) {
      emit(state.copyWith(statusCreate: -1));
    } else {
      emit(state.copyWith(statusCreate: 1));
    }
    emit(state.copyWith(statusCreate: 0));
  }

  void onProductDetails(AdminProductDetailsEvent event, Emitter<AdminProductState> emit) async {
    emit(state.copyWith(getLoading: true));
    var data = await productRepo.getProductDetailsForAdmin("admin/serviceDetails?idService=${event.idService}");
    emit(state.copyWith(readProduct: data, getLoading: false, getProductDetails: true));
    emit(state.copyWith(getProductDetails: false));
  }

  
  // Untils
  void onIdAreaProduct(AdminIdAreaEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(idArea: event.idArea));
  }

  void onIdCategoryProduct(AdminIdCategoryEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(idCategory: event.idCategory));
  }

  void onCurrentIndexProduct(AdminCurrentIndexProductEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(curentIndex: event.currentIndex));
  }

  // Image
  void onUnSelectImages(AdminUnSelectMultipleImageEvent event, Emitter<AdminProductState> emit) {
    
  }

  void onSelectImages(AdminSelectMultipleImageEvent event, Emitter<AdminProductState> emit) {
    emit(state.copyWith(images: event.images));
  }

  // Dynamic widget
  void onAddDynamicTicketProduct(AdminAddDynamicTicketProductEvent event, Emitter<AdminProductState> emit) {
    List<DynamicTicketWidget> temp = state.dynamicTicket.toList();
    temp.add(DynamicTicketWidget());
    emit(state.copyWith(dynamicTicket: temp));
  }

  void onAddDynamicScheduleProduct(AdminAddDynamicScheduleProductEvent event, Emitter<AdminProductState> emit) {
    List<DynamicScheduleWidget> temp = state.dynamicSchedule.toList();
    temp.add(DynamicScheduleWidget());
    emit(state.copyWith(dynamicSchedule: temp));
  }
}