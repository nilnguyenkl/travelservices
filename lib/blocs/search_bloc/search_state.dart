import 'package:equatable/equatable.dart';
import 'package:travelservices/models/product_model.dart';

class SearchState extends Equatable {
  
  final List<ProductData> products;
  final bool getLoading; 
  final bool statusBar;
  final bool statusSearch;
  final String strSearch;
  final int area;
  final int category;

  const SearchState({
    required this.strSearch,
    required this.area,
    required this.category,
    required this.products,
    required this.getLoading,
    required this.statusBar,
    required this.statusSearch
  });

  factory SearchState.empty() {
    return const SearchState(
      products: <ProductData>[], 
      getLoading: false, 
      statusBar: false, 
      statusSearch: false,
      strSearch: '',
      area: 0,
      category: 0
    );
  }

  SearchState copyWith({
    List<ProductData>? products,
    bool? getLoading,
    bool? statusBar,
    bool? statusSearch,
    int? category,
    int? area,
    String? strSearch
  }) {
    return SearchState(
      products: products ?? this.products, 
      getLoading: getLoading ?? this.getLoading, 
      statusBar: statusBar ?? this.statusBar,
      statusSearch: statusSearch ?? this.statusSearch, 
      area: area ?? this.area, 
      category: category ?? this.category, 
      strSearch: strSearch ?? this.strSearch
    );
  }
  
  @override
  List<Object?> get props => [products, getLoading, statusBar, statusSearch, area, strSearch, category];

}