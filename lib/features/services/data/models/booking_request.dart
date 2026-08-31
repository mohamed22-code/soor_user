class BookingRequest {
  final String serviceId;
  final String lat;
  final String long;
  final String areaName;
  final String buildingName;
  final String floor;
  final String addressDetails;
  final String city;
  final String region;
  final String street;
  final String startDatetime;
  final String durationHours;
  final String guardsCount;
  final String dressType;
  final String language;
  final String hasCoordinator;
  final String? coordinatorName;
  final String? coordinatorPhone;
  final String? additionalNotes;
  final String paymentMethod;

  BookingRequest({
    required this.serviceId,
    required this.lat,
    required this.long,
    required this.areaName,
    required this.buildingName,
    required this.floor,
    required this.addressDetails,
    required this.city,
    required this.region,
    required this.street,
    required this.startDatetime,
    required this.durationHours,
    required this.guardsCount,
    required this.dressType,
    required this.language,
    required this.hasCoordinator,
    this.coordinatorName,
    this.coordinatorPhone,
    this.additionalNotes,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
    'service_id': serviceId,
    'lat': lat,
    'long': long,
    'area_name': areaName,
    'building_name': buildingName,
    'floor': floor,
    'address_details': addressDetails,
    'city': city,
    'region': region,
    'street': street,
    'start_datetime': startDatetime,
    'duration_hours': durationHours,
    'guards_count': guardsCount,
    'dress_type': dressType,
    'language': language,
    'has_coordinator': hasCoordinator,
    if (coordinatorName != null) 'coordinator_name': coordinatorName,
    if (coordinatorPhone != null) 'coordinator_phone': coordinatorPhone,
    if (additionalNotes != null) 'additional_notes': additionalNotes,
    'payment_method': paymentMethod,
  };
}

class BookingResponse {
  final bool? status;
  final String? message;
  final dynamic data;

  BookingResponse({this.status, this.message, this.data});

  factory BookingResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return BookingResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: json['data'],
      );
    }
    return BookingResponse(status: true, data: json);
  }
}
