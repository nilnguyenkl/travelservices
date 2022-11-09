import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminSelectMultipleImageEvent extends AdminProductEvent {
  final List<XFile> images;
  AdminSelectMultipleImageEvent({
    required this.images
  });
}

class AdminUnSelectMultipleImageEvent extends AdminProductEvent {

}

class AdminAddProductEvent extends AdminProductEvent {
  AdminAddProductEvent();  
}