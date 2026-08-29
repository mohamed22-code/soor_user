class TermsModel {
  final int? id;
  final String? title;
  final String? content;
  final String? description;

  TermsModel({this.id, this.title, this.content, this.description});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      title: json['title']?.toString() ?? json['name']?.toString(),
      content:
          json['content']?.toString() ??
          json['description']?.toString() ??
          json['text']?.toString() ??
          json['value']?.toString(),
      description: json['description']?.toString(),
    );
  }
}

class TermsResponse {
  final bool? status;
  final String? message;
  final TermsModel? data;
  final List<TermsModel> list;

  TermsResponse({this.status, this.message, this.data, this.list = const []});

  factory TermsResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      final rawData = json['data'];
      if (rawData is List) {
        return TermsResponse(
          status: json['status'] as bool?,
          message: json['message']?.toString(),
          list: rawData
              .map((e) => TermsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      } else if (rawData is Map<String, dynamic>) {
        // could be {data:{content:...}} or paginated
        if (rawData['data'] is List) {
          return TermsResponse(
            status: json['status'] as bool?,
            message: json['message']?.toString(),
            list: (rawData['data'] as List)
                .map((e) => TermsModel.fromJson(e))
                .toList(),
          );
        }
        return TermsResponse(
          status: json['status'] as bool?,
          message: json['message']?.toString(),
          data: TermsModel.fromJson(rawData),
        );
      } else if (rawData is String) {
        return TermsResponse(
          status: json['status'] as bool?,
          message: json['message']?.toString(),
          data: TermsModel(content: rawData),
        );
      }
      if (json['content'] != null || json['terms'] != null) {
        return TermsResponse(data: TermsModel.fromJson(json));
      }
    }
    if (json is List) {
      return TermsResponse(
        list: json.map((e) => TermsModel.fromJson(e)).toList(),
      );
    }
    return TermsResponse(data: TermsModel(content: json.toString()));
  }

  String get displayText {
    if (data?.content != null && data!.content!.isNotEmpty)
      return data!.content!;
    if (list.isNotEmpty) return list.map((e) => e.content ?? '').join('\n\n');
    return '';
  }
}
