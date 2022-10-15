import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/blocs/search_bloc/search_state.dart';
import 'package:travelservices/models/product_model.dart';
import 'package:travelservices/repositories/favorite_repositories.dart';
import 'package:travelservices/repositories/product_repositories.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {


  // Repo
  ProductRepository productRepository = ProductRepository();
  FavoriteRepository favoriteRepository = FavoriteRepository();
  
  // Bloc
  final FavoriteBloc favoriteBloc;
  final NavbarBloc navbarBloc;

  // Stream
  StreamSubscription? streamNavbar;
  
  SearchBloc({
    required this.favoriteBloc,
    required this.navbarBloc
  }) : super(SearchState.empty()){
    on<SearchAreaEvent>(_onSearchArea);
    on<SearchCategoryEvent>(_onSearchCategory);
    on<SearchStringEvent>(_onSearchString);
    on<SearchFocusEvent>(_onSearchFocus);
    on<SearchLoadEvent>(_onSeachLoad);
  }
  

  void _onSearchArea(SearchAreaEvent event, Emitter<SearchState> emit) {
    
  }

  void _onSearchCategory(SearchCategoryEvent event, Emitter<SearchState> emit) {
  
  }

  void _onSearchString(SearchStringEvent event, Emitter<SearchState> emit) {

    emit(state.copyWith(strSearch: event.strSearch));

  }

  void _onSearchFocus(SearchFocusEvent event, Emitter<SearchState> emit) {

    emit(state.copyWith(statusBar: event.focusStatus));

    streamNavbar = navbarBloc.stream.listen((state) async {
      var navbarState = state;
      if (navbarState.statusSearch) {
        add(SearchFocusEvent(true));
      }

    });

  }

  void _onSeachLoad(SearchLoadEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(getLoading: true));
    List<ProductData> data = await productRepository.getListProduct("public/service?page=1&limit=3&search=${state.strSearch}");
    emit(state.copyWith(products: data, statusSearch: true, getLoading: false));
  }
  
}