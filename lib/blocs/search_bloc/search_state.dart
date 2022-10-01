import 'package:equatable/equatable.dart';
import 'package:travelservices/models/product_model.dart';

class SearchState extends Equatable {
  
  final List<ProductData> products;
  final bool getLoading;
  
  final bool statusBar;
  final bool statusSearch;

  const SearchState({
    required this.products,
    required this.getLoading,
    required this.statusBar,
    required this.statusSearch
  });

  factory SearchState.empty() {
    return const SearchState(products: <ProductData>[], getLoading: false, statusBar: false, statusSearch: false);
  }

  SearchState copyWith({
    List<ProductData>? products,
    bool? getLoading,
    bool? statusBar,
    bool? statusSearch
  }) {
    return SearchState(
      products: products ?? this.products, 
      getLoading: getLoading ?? this.getLoading, 
      statusBar: statusBar ?? this.statusBar,
      statusSearch: statusSearch ?? this.statusSearch
    );
  }
  
  @override
  List<Object?> get props => [products, getLoading, statusBar, statusSearch];

}