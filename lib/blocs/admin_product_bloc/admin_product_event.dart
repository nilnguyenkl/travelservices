import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class AdminProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminAddProductEvent extends AdminProductEvent {
  final CreateProduct product;
  AdminAddProductEvent({
    required this.product
  });  
}

class AdminProductDetailsEvent extends AdminProductEvent {
  final int idService;
  AdminProductDetailsEvent({
    required this.idService
  });
}

class AdminSelectMultipleImageEvent extends AdminProductEvent {
  final List<XFile> images;
  AdminSelectMultipleImageEvent({
    required this.images
  });
}

class AdminUnSelectMultipleImageEvent extends AdminProductEvent {
  // Chua sai
}

class AdminIdCategoryEvent extends AdminProductEvent {
  final int idCategory;
  AdminIdCategoryEvent({
    required this.idCategory
  });
}

class AdminIdAreaEvent extends AdminProductEvent {
  final int idArea;
  AdminIdAreaEvent({
    required this.idArea
  });
}

class AdminCurrentIndexProductEvent extends AdminProductEvent {
  final int currentIndex;
  AdminCurrentIndexProductEvent({
    required this.currentIndex
  });
}

class AdminAddDynamicTicketProductEvent extends AdminProductEvent{
  AdminAddDynamicTicketProductEvent();
}

class AdminAddDynamicScheduleProductEvent extends AdminProductEvent{
  AdminAddDynamicScheduleProductEvent();
}