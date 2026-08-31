class RatingCriteriaModel {
  final int id;
  final String name;
  final String? description;

  RatingCriteriaModel({required this.id, required this.name, this.description});

  factory RatingCriteriaModel.fromJson(Map<String, dynamic> json) {
    return RatingCriteriaModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name:
          json['name']?.toString() ??
          json['title']?.toString() ??
          json['criteria']?.toString() ??
          'معيار ${json['id']}',
      description: json['description']?.toString(),
    );
  }
}

class RatingCriteriaResponse {
  final bool? status;
  final String? message;
  final List<RatingCriteriaModel> data;

  RatingCriteriaResponse({this.status, this.message, required this.data});

  factory RatingCriteriaResponse.fromJson(dynamic json) {
    if (json is List) {
      return RatingCriteriaResponse(
        data: json
            .map((e) => RatingCriteriaModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      final raw = json['data'];
      List<RatingCriteriaModel> list = [];
      if (raw is List) {
        list = raw
            .map((e) => RatingCriteriaModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (raw is Map<String, dynamic> && raw['data'] is List) {
        list = (raw['data'] as List)
            .map((e) => RatingCriteriaModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return RatingCriteriaResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
      );
    }
    return RatingCriteriaResponse(data: []);
  }
}
