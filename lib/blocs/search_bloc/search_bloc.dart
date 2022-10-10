import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/blocs/search_bloc/search_state.dart';
import 'package:travelservices/models/product_model.dart';
import 'package:travelservices/repositories/product_repositories.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  ProductRepository productRepository = ProductRepository();

  SearchBloc() : super(SearchState.empty()){
    on<SearchAreaEvent>(_onSearchArea);
    on<SearchCategoryEvent>(_onSearchCategory);
    on<SearchStringEvent>(_onSearchString);
    on<SearchFocusEvent>(_onSearchFocus);
  }
  

  void _onSearchArea(SearchAreaEvent event, Emitter<SearchState> emit) {
    
  }

  void _onSearchCategory(SearchCategoryEvent event, Emitter<SearchState> emit) {
  
  }

  void _onSearchString(SearchStringEvent event, Emitter<SearchState> emit) async {
    print("Value: ${event.strSearch}");

    List<ProductData> data = await productRepository.getListProduct("public/service?page=1&limit=3&search=${event.strSearch}");
    emit(state.copyWith(products: data));
    emit(state.copyWith(statusSearch: true));

    

  }

  void _onSearchFocus(SearchFocusEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(statusBar: event.focusStatus));
  }
}