class BookingModel {
  final int? id;
  final String? bookingNumber;
  final String? status;
  final String? statusKey;
  final String? date;
  final String? endDate;
  final String? price;
  final String? totalPrice;
  final String? guardsCount;
  final String? durationHours;
  final String? address;
  final String? paymentMethod;
  final String? serviceName;
  final int? serviceId;
  final int? guardId;
  final bool? canRate;

  BookingModel({
    this.id,
    this.bookingNumber,
    this.status,
    this.statusKey,
    this.date,
    this.endDate,
    this.price,
    this.totalPrice,
    this.guardsCount,
    this.durationHours,
    this.address,
    this.paymentMethod,
    this.serviceName,
    this.serviceId,
    this.guardId,
    this.canRate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final idVal = json['id'] ?? json['booking_id'];
    final id = idVal is int ? idVal : int.tryParse(idVal?.toString() ?? '');
    final status =
        json['status']?.toString() ??
        json['booking_status']?.toString() ??
        json['state']?.toString();
    final statusKey = status;
    // Arabic mapping fallback
    String? arabicStatus;
    if (status != null) {
      final lower = status.toLowerCase();
      if (lower.contains('pending') || lower.contains('waiting'))
        arabicStatus = 'قبول الحارس';
      else if (lower.contains('arrived') || lower.contains('وصول'))
        arabicStatus = 'وصول الحارس';
      else if (lower.contains('completed') ||
          lower.contains('finished') ||
          lower.contains('منتهي'))
        arabicStatus = 'منتهي';
      else
        arabicStatus = status;
    }
    final date =
        json['start_datetime']?.toString() ??
        json['start_date']?.toString() ??
        json['date']?.toString() ??
        json['created_at']?.toString();
    final price =
        json['total_price']?.toString() ??
        json['price']?.toString() ??
        json['amount']?.toString();
    final guards =
        json['guards_count']?.toString() ?? json['guards']?.toString();
    final duration =
        json['duration_hours']?.toString() ?? json['duration']?.toString();
    final address =
        json['area_name']?.toString() ??
        json['address']?.toString() ??
        json['address_details']?.toString() ??
        json['city']?.toString();
    return BookingModel(
      id: id,
      bookingNumber: '#${id ?? json['booking_number']?.toString() ?? '---'}',
      status: arabicStatus ?? 'منتهي',
      statusKey: statusKey,
      date: date ?? 'اليوم 8:00 م الى 11:00 م',
      endDate: json['end_datetime']?.toString(),
      price: price != null ? '$price ريال' : '1600 ريال',
      totalPrice: price,
      guardsCount: guards,
      durationHours: duration,
      address: address,
      paymentMethod: json['payment_method']?.toString(),
      serviceName: json['service'] is Map
          ? (json['service']['name']?.toString())
          : json['service_name']?.toString(),
      serviceId: json['service_id'] is int
          ? json['service_id']
          : int.tryParse(json['service_id']?.toString() ?? ''),
      guardId: json['guard_id'] is int
          ? json['guard_id']
          : int.tryParse(json['guard_id']?.toString() ?? '') ??
                (json['guard'] is Map
                    ? int.tryParse(json['guard']['id']?.toString() ?? '')
                    : null),
      canRate: json['can_rate'] as bool? ?? (arabicStatus == 'منتهي'),
    );
  }
}

class BookingsPaginatedResponse {
  final bool? status;
  final String? message;
  final List<BookingModel> data;
  final int? currentPage;
  final int? lastPage;
  final int? total;

  BookingsPaginatedResponse({
    this.status,
    this.message,
    required this.data,
    this.currentPage,
    this.lastPage,
    this.total,
  });

  factory BookingsPaginatedResponse.fromJson(dynamic json) {
    if (json is List) {
      return BookingsPaginatedResponse(
        data: json
            .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    }
    if (json is Map<String, dynamic>) {
      dynamic raw = json['data'];
      List<BookingModel> list = [];
      int? cur, last, total;
      if (raw is List) {
        list = raw
            .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
            .toList();
        cur = json['current_page'] is int
            ? json['current_page']
            : int.tryParse(json['current_page']?.toString() ?? '');
        last = json['last_page'] is int
            ? json['last_page']
            : int.tryParse(json['last_page']?.toString() ?? '');
        total = json['total'] is int
            ? json['total']
            : int.tryParse(json['total']?.toString() ?? '');
      } else if (raw is Map<String, dynamic>) {
        if (raw['data'] is List) {
          list = (raw['data'] as List)
              .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        cur = raw['current_page'] is int
            ? raw['current_page']
            : int.tryParse(raw['current_page']?.toString() ?? '');
        last = raw['last_page'] is int
            ? raw['last_page']
            : int.tryParse(raw['last_page']?.toString() ?? '');
        total = raw['total'] is int
            ? raw['total']
            : int.tryParse(raw['total']?.toString() ?? '');
      }
      return BookingsPaginatedResponse(
        status: json['status'] as bool?,
        message: json['message']?.toString(),
        data: list,
        currentPage: cur,
        lastPage: last,
        total: total,
      );
    }
    return BookingsPaginatedResponse(data: []);
  }
}
