import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelservices/models/product_admin_model.dart';
import 'package:travelservices/screens/widgets/dynamic_schedule_widget.dart';
import 'package:travelservices/screens/widgets/dynamic_ticket_widget.dart';

class AdminProductState extends Equatable {
  
  final bool getLoading;
  final bool getProductDetails;

  final List<XFile> images;
  final int statusUploadImages;

  final ProductDetails? readProduct;

  final CreateProduct? product; 
  final int statusCreate;

  final int idCategory;
  final int idArea;
  final int curentIndex;

  final List<DynamicTicketWidget> dynamicTicket;
  final List<DynamicScheduleWidget> dynamicSchedule;

  const AdminProductState({
    required this.getLoading,
    required this.images,
    required this.product,
    required this.statusCreate,
    required this.statusUploadImages,
    required this.idArea,
    required this.idCategory,
    required this.curentIndex,
    required this.dynamicTicket,
    required this.dynamicSchedule,
    required this.readProduct,
    required this.getProductDetails
  });

  factory AdminProductState.empty() {
    return const AdminProductState(
      getLoading: false, 
      getProductDetails: false,
      images: <XFile>[],
      statusCreate: 0,
      statusUploadImages: 0,
      idArea: 0,
      idCategory: 0,
      curentIndex: 0,
      dynamicTicket: <DynamicTicketWidget>[],
      dynamicSchedule: <DynamicScheduleWidget>[],
      product: null,
      readProduct: null,
    );
  }

  AdminProductState copyWith({
    bool? getLoading,
    List<XFile>? images,
    CreateProduct? product,
    int? statusCreate,
    int? statusUploadImages,
    int? idArea,
    int? idCategory,
    int? curentIndex,
    List<DynamicTicketWidget>? dynamicTicket,
    List<DynamicScheduleWidget>? dynamicSchedule,
    ProductDetails? readProduct,
    bool? getProductDetails
  }) {
    return AdminProductState(
      getLoading: getLoading ?? this.getLoading, 
      images: images ?? this.images,
      product: product ?? this.product,
      statusCreate: statusCreate ?? this.statusCreate,
      statusUploadImages: statusUploadImages ?? this.statusUploadImages,
      idArea: idArea ?? this.idArea,
      idCategory: idCategory ?? this.idCategory,
      curentIndex: curentIndex ?? this.curentIndex,
      dynamicTicket: dynamicTicket ?? this.dynamicTicket,
      dynamicSchedule: dynamicSchedule ?? this.dynamicSchedule,
      readProduct: readProduct ?? this.readProduct,
      getProductDetails: getProductDetails ?? this.getProductDetails
    );
  }
  
  @override
  List<Object?> get props => [
    getLoading, 
    getProductDetails,
    images, 
    product, 
    statusCreate, 
    statusUploadImages, 
    idCategory, 
    idArea, 
    curentIndex, 
    dynamicTicket,
    dynamicSchedule,
    readProduct
  ];

}