import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_event.dart';
import 'package:travelservices/blocs/admin_order_bloc/admin_order_state.dart';
import 'package:travelservices/repositories/order_repositories.dart';

class AdminOrderBloc extends Bloc<AdminOrderEvent, AdminOrderState> {
  OrderRepository orderRepo = OrderRepository();
  AdminOrderBloc() : super(AdminOrderState.empty()) {
    on<AdminOrderReadByPendingEvent>(onReadByPendingEvent);
    on<AdminOrderReadByApprovedEvent>(onReadByApprovedEvent);
    on<AdminOrderApprovedEvent>(onApprovedEvent);
    on<AdminOrderCancelEvent>(onCancelEvent);
    on<AdminOrderExperienceEvent>(onExperienceEvent);
  }

  void onReadByPendingEvent(AdminOrderReadByPendingEvent event, Emitter<AdminOrderState> emit) async {
    emit(state.copyWith(statusReadPending: true));
    var data = await orderRepo.getOrderForAdmin("admin/orderitem/waiting?limit=99&page=1");
    emit(state.copyWith(statusReadPending: false, ordersByPending: data));
  }

  void onReadByApprovedEvent(AdminOrderReadByApprovedEvent event, Emitter<AdminOrderState> emit) async {
    emit(state.copyWith(statusReadPending: true));
    var data = await orderRepo.getOrderForAdmin("admin/orderitem/approved?limit=99&page=1");
    emit(state.copyWith(statusReadApproved: false, ordersByApproved: data));
  }

  void onApprovedEvent(AdminOrderApprovedEvent event, Emitter<AdminOrderState> emit) {
    
  }

  void onCancelEvent(AdminOrderCancelEvent event, Emitter<AdminOrderState> emit) {
  
  }

  void onExperienceEvent(AdminOrderExperienceEvent event, Emitter<AdminOrderState> emit) {
  
  }
}