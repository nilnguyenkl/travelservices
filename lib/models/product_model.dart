import 'package:travelservices/models/ticket_model.dart';

class ProductData {

  final int id;
  final String? name;
  final String? description;
  final String? image;
  final int idCategory;
  final int idArea;
  final List<TicketModel> ticket;
  final int reviews;
  final int orders;
  final DateTime createDate;
  final DateTime modifiedDate;

  ProductData({
    required this.id,
    this.name,
    this.description,
    this.image,
    required this.idCategory,
    required this.idArea,
    required this.ticket,
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
      idCategory: json["idCategory"],
      idArea: json["idArea"],
      ticket: List<TicketModel>.from(json["ticket"].map((x) => TicketModel.fromJson(x))),
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
      "idCategory": idCategory,
      "idArea": idArea,
      "ticket": List<dynamic>.from(ticket.map((x) => x.toJson())),
      "reviews": reviews,
      "orders": orders,
      "createDate": createDate.toIso8601String(),
      "modifiedDate": modifiedDate.toIso8601String(),
    };
    
}