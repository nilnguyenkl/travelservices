class CreateProduct {
  final InforProduct service;
  final List<TicketForProductForAdd> ticket;
  final List<ScheduleProductForAdd> schedule;
  final List<GalleryProduct> galleries;

  CreateProduct({
    required this.service,
    required this.ticket,
    required this.schedule,
    required this.galleries,
  });

  Map<String, dynamic> toJson() => {
    "service": service.toJson(),
    "ticket": List<dynamic>.from(ticket.map((x) => x.toJson())),
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
  };
}

class GalleryProduct {
  final int id;
  final String url;
  final String type;

  GalleryProduct({
    required this.id,
    required this.url,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "type": type,
  };
}

class ScheduleProductForAdd {
  final String time;
  final int quantityPerDay;

  ScheduleProductForAdd({
    required this.time,
    required this.quantityPerDay,
  });

  Map<String, dynamic> toJson() => {
    "time": time,
    "quantityPerDay": quantityPerDay,
  };

}

class InforProduct {
  
  final String name;
  final String address;
  final String description;
  final String event;
  final String note;
  final int idArea;
  final int idCategory;

  InforProduct({
    required this.name,
    required this.address,
    required this.description,
    required this.event,
    required this.note,
    required this.idArea,
    required this.idCategory,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "description": description,
    "event": event,
    "note": note,
    "idArea": idArea,
    "idCategory": idCategory,
  };

}

class TicketForProductForAdd {
  
  final int valueTicket;
  final String typeTicket;
  final String noteTicket;
  final int amountTicket;
  
  TicketForProductForAdd({
    required this.valueTicket,
    required this.typeTicket,
    required this.noteTicket,
    required this.amountTicket,
  });

  Map<String, dynamic> toJson() => {
    "valueTicket": valueTicket,
    "typeTicket": typeTicket,
    "noteTicket": noteTicket,
    "amountTicket": amountTicket,
  };

}
