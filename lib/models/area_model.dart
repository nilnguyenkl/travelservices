class AreaData {
    
  final int id;
  final String? name;
  final String? url;
  
  AreaData({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}