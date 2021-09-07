import 'dart:convert';

class WkUserSubscription {
  final bool active;
  final String type;
  final int maxLevelGranted;
  final String? periodEndsAt;

  WkUserSubscription({
    required this.active,
    required this.type,
    required this.maxLevelGranted,
    this.periodEndsAt,
  });

  WkUserSubscription copyWith({
    bool? active,
    String? type,
    int? maxLevelGranted,
    String? periodEndsAt,
  }) {
    return WkUserSubscription(
      active: active ?? this.active,
      type: type ?? this.type,
      maxLevelGranted: maxLevelGranted ?? this.maxLevelGranted,
      periodEndsAt: periodEndsAt ?? this.periodEndsAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'type': type,
      'max_level_granted': maxLevelGranted,
      'period_ends_at': periodEndsAt,
    };
  }

  factory WkUserSubscription.fromMap(Map<String, dynamic> map) {
    return WkUserSubscription(
      active: map['active'],
      type: map['type'],
      maxLevelGranted: map['max_level_granted'],
      periodEndsAt: map['period_ends_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WkUserSubscription.fromJson(String source) =>
      WkUserSubscription.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WkUserSubscription(active: $active, type: $type, maxLevelGranted: $maxLevelGranted, periodEndsAt: $periodEndsAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WkUserSubscription &&
        other.active == active &&
        other.type == type &&
        other.maxLevelGranted == maxLevelGranted &&
        other.periodEndsAt == periodEndsAt;
  }

  @override
  int get hashCode {
    return active.hashCode ^
        type.hashCode ^
        maxLevelGranted.hashCode ^
        periodEndsAt.hashCode;
  }
}
