import 'package:bloc/bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/category_bloc/category_state.dart';
import 'package:travelservices/models/category_model.dart';
import 'package:travelservices/repositories/category_repositories.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryRepository categoryRepository = CategoryRepository();

  CategoryBloc() : super(CategoryState.empty()){
    on<CategoryLoadEvent>(onCategoryLoad);
    on<CategoryReadEvent>(onCategoryRead);
    on<CategoryClickEvent>(onCategoryClick);
  }  

  void onCategoryLoad(CategoryLoadEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(getLoading: true));
    List<CategoryData> data = await categoryRepository.getListCategories("public/category");
    emit(state.copyWith(categories: data));

  }

  void onCategoryRead(CategoryReadEvent event, Emitter<CategoryState> emit) {
    emit(state.copyWith(categories: event.categories));
  }

  void onCategoryClick(CategoryClickEvent event, Emitter<CategoryState> emit) {
    emit(state.copyWith(statusClick: true, clickCategory: event.category));
  }

}