import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class AdminProductState extends Equatable {
  
  final bool getLoading;
  final List<XFile> images;
  
  const AdminProductState({
    required this.getLoading,
    required this.images
  });

  factory AdminProductState.empty() {
    return const AdminProductState(
      getLoading: false, 
      images: <XFile>[]
    );
  }

  AdminProductState copyWith({
    bool? getLoading,
    List<XFile>? images
  }) {
    return AdminProductState(
      getLoading: getLoading ?? this.getLoading, 
      images: images ?? this.images
    );
  }
  
  @override
  List<Object?> get props => [getLoading, images];

}