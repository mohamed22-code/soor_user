class ServiceModel {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final String? icon;
  final String? price;
  final String? hourPrice;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.icon,
    this.price,
    this.hourPrice,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      name:
          json['name']?.toString() ??
          json['title']?.toString() ??
          json['service_name']?.toString(),
      description: json['description']?.toString() ?? json['desc']?.toString(),
      image:
          json['image']?.toString() ??
          json['img']?.toString() ??
          json['image_url']?.toString() ??
          json['service_image']?.toString(),
      icon: json['icon']?.toString(),
      price: json['price']?.toString() ?? json['hour_price']?.toString(),
      hourPrice: json['hour_price']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'image': image,
    'icon': icon,
    'price': price,
    'hour_price': hourPrice,
    'hourPrice': hourPrice,
  };
}

class ServicesResponse {
  final bool? status;
  final String? message;
  final List<ServiceModel> data;
  final int? currentPage;
  final int? lastPage;

  ServicesResponse({
    this.status,
    this.message,
    required this.data,
    this.currentPage,
    this.lastPage,
  });

  factory ServicesResponse.fromJson(dynamic json) {
    if (json is List) {
      return ServicesResponse(
        data: json.map((e) => ServiceModel.fromJson(e)).toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      dynamic rawData = json['data'];
      List<ServiceModel> list = [];
      int? cur;
      int? last;
      if (rawData is List) {
        list = rawData
            .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map<String, dynamic>) {
        if (rawData['data'] is List) {
          list = (rawData['data'] as List)
              .map((e) => ServiceModel.fromJson(e))
              .toList();
        }
        cur = rawData['current_page'] is int
            ? rawData['current_page']
            : int.tryParse(rawData['current_page']?.toString() ?? '');
        last = rawData['last_page'] is int
            ? rawData['last_page']
            : int.tryParse(rawData['last_page']?.toString() ?? '');
      }
      return ServicesResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
        currentPage: cur,
        lastPage: last,
      );
    }
    return ServicesResponse(data: []);
  }
}
