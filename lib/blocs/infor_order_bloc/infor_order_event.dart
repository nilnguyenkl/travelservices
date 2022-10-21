import 'package:equatable/equatable.dart';

class InforOrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InforOrderReadCalendarEvent extends InforOrderEvent {
  final int idService;
  InforOrderReadCalendarEvent({
    required this.idService
  });
}

class InforOrderSelectDayEvent extends InforOrderEvent {
  final int idService;
  final DateTime focusDay;
  final DateTime selectDay; 

  InforOrderSelectDayEvent({
    required this.focusDay,
    required this.selectDay,
    required this.idService,
  });
}

class InforOrderScheduleEvent extends InforOrderEvent {
  final String schedule;
  InforOrderScheduleEvent({
    required this.schedule
  });
}

class InforOrderValueTicketEvent extends InforOrderEvent {
  final int index;
  final bool status;
  InforOrderValueTicketEvent({
    required this.index,
    required this.status,
  });
}
