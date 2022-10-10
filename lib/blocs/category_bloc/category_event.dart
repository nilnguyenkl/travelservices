import 'package:equatable/equatable.dart';
import 'package:travelservices/models/category_model.dart';

class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryLoadEvent extends CategoryEvent {}

class CategoryReadEvent extends CategoryEvent {
  
  final List<CategoryData> categories;

  const CategoryReadEvent({
    required this.categories
  });

}