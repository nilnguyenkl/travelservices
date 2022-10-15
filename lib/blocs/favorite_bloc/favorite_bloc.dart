import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_state.dart';
import 'package:travelservices/repositories/favorite_repositories.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {

  FavoriteRepository repo = FavoriteRepository();

  FavoriteBloc({
    required this.repo,
  }) : super(FavoriteState.empty()) {
    on<FavoriteReadEvent>(favoriteRead);
    on<FavoriteAddEvent>(favoriteAdd);
    on<FavoriteDeleteEvent>(favoriteDelete);
  }

  void favoriteRead(FavoriteReadEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(getLoading: true, statusAdd: false, statusDelete: false));
    var data = await repo.getListFavorite("favorite");
    emit(state.copyWith(favorites: data, getLoading: false));
  }

  void favoriteAdd(FavoriteAddEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(statusAdd: true));
    repo.insertFavorite("favorite?idService=", event.idProduct.toString());
    add(FavoriteReadEvent());
  }

  void favoriteDelete(FavoriteDeleteEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(statusDelete: true));
    Api api = Api();
    await api.deleteFavorite(Api.url, "favorite?idService=", event.idProduct.toString());
    add(FavoriteReadEvent());
  }

}