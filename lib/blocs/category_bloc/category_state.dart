import 'package:equatable/equatable.dart';
import 'package:travelservices/models/category_model.dart';

class CategoryState extends Equatable {

  final List<CategoryData> categories;
  final bool getLoading;

  const CategoryState({
    required this.categories,
    required this.getLoading
  });

  factory CategoryState.empty() {
    return const CategoryState(categories: <CategoryData>[], getLoading: false);
  }

  CategoryState copyWith ({
    List<CategoryData>? categories,
    bool? getLoading
  }) {
    return CategoryState(
      categories: categories ?? this.categories, 
      getLoading: getLoading ?? this.getLoading
    );
  }

  @override
  List<Object?> get props => [categories, getLoading];

}