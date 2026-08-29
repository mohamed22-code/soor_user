class SliderModel {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? link;

  SliderModel({this.id, this.title, this.description, this.image, this.link});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      title: json['title']?.toString() ?? json['name']?.toString(),
      description: json['description']?.toString() ?? json['desc']?.toString(),
      image:
          json['image']?.toString() ??
          json['img']?.toString() ??
          json['image_url']?.toString() ??
          json['slider_image']?.toString(),
      link: json['link']?.toString() ?? json['url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': image,
    'link': link,
  };
}

class SlidersResponse {
  final bool? status;
  final String? message;
  final List<SliderModel> data;

  SlidersResponse({this.status, this.message, required this.data});

  factory SlidersResponse.fromJson(dynamic json) {
    if (json is List) {
      return SlidersResponse(
        data: json.map((e) => SliderModel.fromJson(e)).toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      final rawData = json['data'];
      List<SliderModel> list = [];
      if (rawData is List) {
        list = rawData
            .map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (rawData is Map<String, dynamic> && rawData['data'] is List) {
        list = (rawData['data'] as List)
            .map((e) => SliderModel.fromJson(e))
            .toList();
      }
      return SlidersResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
      );
    }
    return SlidersResponse(data: []);
  }
}
