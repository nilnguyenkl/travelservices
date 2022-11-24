import 'package:equatable/equatable.dart';

class AdminOrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminOrderReadByPendingEvent extends AdminOrderEvent {
  AdminOrderReadByPendingEvent();
}

class AdminOrderReadByApprovedEvent extends AdminOrderEvent {
  AdminOrderReadByApprovedEvent();
}

class AdminOrderApprovedEvent extends AdminOrderEvent {
  final int idOrderItem;
  final String status;
  final String text;
  AdminOrderApprovedEvent({
    required this.idOrderItem,
    required this.status,
    required this.text
  });
}

class AdminOrderCancelEvent extends AdminOrderEvent {
  final int idOrderItem;
  final String status;
  final String text;
  AdminOrderCancelEvent({
    required this.idOrderItem,
    required this.status,
    required this.text
  });
}

class AdminOrderExperienceEvent extends AdminOrderEvent {
  final int idOrderItem;
  final String status;
  AdminOrderExperienceEvent({
    required this.idOrderItem,
    required this.status
  });
}