class HourPriceModel {
  final String? hourPrice;
  final String? price;
  final String? currency;

  HourPriceModel({this.hourPrice, this.price, this.currency});

  factory HourPriceModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      final data = json['data'] is Map
          ? json['data'] as Map<String, dynamic>
          : json;
      return HourPriceModel(
        hourPrice:
            data['hour_price']?.toString() ??
            data['price']?.toString() ??
            data['value']?.toString(),
        price: data['price']?.toString() ?? data['hour_price']?.toString(),
        currency: data['currency']?.toString() ?? 'ريال',
      );
    }
    if (json is String || json is num) {
      return HourPriceModel(hourPrice: json.toString());
    }
    return HourPriceModel(hourPrice: '0');
  }

  double get priceDouble => double.tryParse(hourPrice ?? '0') ?? 0;

  String get displayPrice => '${hourPrice ?? '0'} ${currency ?? 'ريال'}';
}
