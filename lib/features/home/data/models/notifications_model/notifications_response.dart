class NotificationsResponse {
  NotificationsResponse({this.notifications});

  factory NotificationsResponse.fromJson(dynamic json) {
    final list = <NotificationItem>[];

    if (json is List) {
      for (final v in json) {
        if (v is Map<String, dynamic>) list.add(NotificationItem.fromJson(v));
      }
    }
    else if (json is Map) {
      final raw = json['notifications'];
      if (raw is List) {
        for (final v in raw) {
          if (v is Map<String, dynamic>) list.add(NotificationItem.fromJson(v));
        }
      }
    }

    return NotificationsResponse(notifications: list);
  }

  final List<NotificationItem>? notifications;

  Map<String, dynamic> toJson() => {
    if (notifications != null)
      'notifications': notifications!.map((e) => e.toJson()).toList(),
  };
}

class NotificationItem {
  NotificationItem({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json['id']?.toString(),
    type: json['type']?.toString(),
    notifiableType: json['notifiable_type']?.toString(),
    notifiableId: json['notifiable_id'] is int
        ? json['notifiable_id'] as int
        : int.tryParse(json['notifiable_id']?.toString() ?? ''),
    data: json['data'] is Map<String, dynamic>
        ? NotificationData.fromJson(json['data'] as Map<String, dynamic>)
        : null,
    readAt: json['read_at']?.toString(),
    createdAt: json['created_at']?.toString(),
    updatedAt: json['updated_at']?.toString(),
  );

  final String? id;
  final String? type;
  final String? notifiableType;
  final int? notifiableId;
  final NotificationData? data;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'notifiable_type': notifiableType,
    'notifiable_id': notifiableId,
    if (data != null) 'data': data!.toJson(),
    'read_at': readAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class NotificationData {
  NotificationData({this.message, this.pnl});

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    message: json['message']?.toString(),
    pnl: _toDouble(json['pnl']),
  );

  final String? message;
  final double? pnl;

  Map<String, dynamic> toJson() => {
    'message': message,
    'pnl': pnl,
  };

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
