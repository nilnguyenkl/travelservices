import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_event.dart';
import 'package:travelservices/blocs/area_bloc/area_state.dart';
import 'package:travelservices/models/area_model.dart';
import 'package:travelservices/repositories/area_repositories.dart';

class AreaBloc extends Bloc<AreaEvent, AreaState> {

  AreaRepository areaRepository = AreaRepository();

  AreaBloc() : super(AreaState.empty()){
    on<AreaLoadEvent>(onAreaLoad);
    on<AreaReadEvent>(onAreaRead);
    on<AreaClickEvent>(onAreaClick);
  }  

  void onAreaLoad(AreaLoadEvent event, Emitter<AreaState> emit) async {
    emit(state.copyWith(getLoading: true));

    List<AreaData> data = await areaRepository.getListArea("public/area");
    emit(state.copyWith(areas: data));

  }

  void onAreaRead(AreaReadEvent event, Emitter<AreaState> emit) {
    emit(state.copyWith(areas: event.areas));
  }



  void onAreaClick(AreaClickEvent event, Emitter<AreaState> emit) {
    emit(state.copyWith(clickArea: event.area, statusClick: true));
  }
}