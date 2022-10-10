import 'package:travelservices/models/schedule_model.dart';
import 'package:travelservices/models/ticket_model.dart';

class ProductData {

  final int id;
  final String? name;
  final String? description;
  final String? image;
  final CategoryData category;
  final AreaData area;
  final List<TicketModel> ticket;
  List<ScheduleModel> schedule;
  final int reviews;
  final int orders;
  final DateTime createDate;
  final DateTime modifiedDate;

  ProductData({
    required this.id,
    this.name,
    this.description,
    this.image,
    required this.category,
    required this.area,
    required this.ticket,
    required this.schedule,
    required this.reviews,
    required this.orders,
    required this.createDate,
    required this.modifiedDate
  });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      category: CategoryData.fromJson(json["category"]),
      area: AreaData.fromJson(json["area"]),
      ticket: List<TicketModel>.from(json["ticket"].map((x) => TicketModel.fromJson(x))),
      schedule: json["schedule"] != null ? List<ScheduleModel>.from(json["schedule"].map((x) => ScheduleModel.fromJson(x))) : [],
      reviews: json["reviews"],
      orders: json["orders"],
      createDate: DateTime.parse(json["createDate"]),
      modifiedDate: DateTime.parse(json["modifiedDate"]),
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "category": category,
      "area": area,
      "ticket": List<dynamic>.from(ticket.map((x) => x.toJson())),
      "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
      "reviews": reviews,
      "orders": orders,
      "createDate": createDate.toIso8601String(),
      "modifiedDate": modifiedDate.toIso8601String(),
    };
    
}


class AreaData {
  
  final int id;
  final String? name;
  
  AreaData({
    required this.id,
    this.name,
  });

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class CategoryData {
  
  final int id;
  final String? name;
  
  CategoryData({
    required this.id,
    this.name,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}