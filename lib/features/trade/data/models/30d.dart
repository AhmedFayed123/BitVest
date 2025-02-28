class ThirtyDays {
  ThirtyDays({this.timestamp, this.price});

  ThirtyDays.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    price = (json['price'] as num?)?.toDouble();
  }

  int? timestamp;
  double? price;

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'price': price,
    };
  }
}
