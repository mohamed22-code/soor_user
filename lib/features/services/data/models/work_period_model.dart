class WorkPeriodModel {
  final int? id;
  final String? name;
  final String? startTime;
  final String? endTime;
  final String? price;

  WorkPeriodModel({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.price,
  });

  factory WorkPeriodModel.fromJson(Map<String, dynamic> json) {
    return WorkPeriodModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      name:
          json['name']?.toString() ??
          json['title']?.toString() ??
          json['period_name']?.toString(),
      startTime: json['start_time']?.toString() ?? json['from']?.toString(),
      endTime: json['end_time']?.toString() ?? json['to']?.toString(),
      price: json['price']?.toString(),
    );
  }

  String get displayName {
    if (name != null && name!.isNotEmpty) return name!;
    if (startTime != null && endTime != null) return '$startTime - $endTime';
    return 'فترة ${id ?? ''}';
  }
}

class WorkPeriodsResponse {
  final bool? status;
  final String? message;
  final List<WorkPeriodModel> data;

  WorkPeriodsResponse({this.status, this.message, required this.data});

  factory WorkPeriodsResponse.fromJson(dynamic json) {
    if (json is List) {
      return WorkPeriodsResponse(
        data: json.map((e) => WorkPeriodModel.fromJson(e)).toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      final raw = json['data'];
      List<WorkPeriodModel> list = [];
      if (raw is List) {
        list = raw
            .map((e) => WorkPeriodModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (raw is Map<String, dynamic> && raw['data'] is List) {
        list = (raw['data'] as List)
            .map((e) => WorkPeriodModel.fromJson(e))
            .toList();
      }
      return WorkPeriodsResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
      );
    }
    return WorkPeriodsResponse(data: []);
  }
}
