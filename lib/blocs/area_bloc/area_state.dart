import 'package:equatable/equatable.dart';
import 'package:travelservices/models/area_model.dart';

class AreaState extends Equatable {

  final List<AreaData> areas;
  final bool getLoading;

  const AreaState({
    required this.areas,
    required this.getLoading
  });

  factory AreaState.empty() {
    return const AreaState(areas: <AreaData>[], getLoading: false);
  }

  AreaState copyWith ({
    List<AreaData>? areas,
    bool? getLoading
  }) {
    return AreaState(
      areas: areas ?? this.areas, 
      getLoading: getLoading ?? this.getLoading
    );
  }

  @override
  List<Object?> get props => [areas, getLoading];

}