import 'package:equatable/equatable.dart';
import 'package:travelservices/models/area_model.dart';

class AreaEvent extends Equatable {
  const AreaEvent();
  @override
  List<Object?> get props => [];
}

class AreaLoadEvent extends AreaEvent {}

class AreaReadEvent extends AreaEvent {
  
  final List<AreaData> areas;

  const AreaReadEvent({
    required this.areas
  });

}