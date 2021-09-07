import 'dart:convert';

import 'package:wani_reminder/models/wk_user_preferences.dart';
import 'package:wani_reminder/models/wk_user_subscription.dart';

class WkUserData {
  final String id;
  final String username;
  final int level;
  final String profileUrl;
  final String startedAt;
  final WkUserSubscription subscription;
  final String? currentVacationStartedAt;
  final WkUserPreferences preferences;

  WkUserData({
    required this.id,
    required this.username,
    required this.level,
    required this.profileUrl,
    required this.startedAt,
    required this.subscription,
    this.currentVacationStartedAt,
    required this.preferences,
  });

  WkUserData copyWith({
    String? id,
    String? username,
    int? level,
    String? profileUrl,
    String? startedAt,
    WkUserSubscription? subscription,
    String? currentVacationStartedAt,
    WkUserPreferences? preferences,
  }) {
    return WkUserData(
      id: id ?? this.id,
      username: username ?? this.username,
      level: level ?? this.level,
      profileUrl: profileUrl ?? this.profileUrl,
      startedAt: startedAt ?? this.startedAt,
      subscription: subscription ?? this.subscription,
      currentVacationStartedAt:
          currentVacationStartedAt ?? this.currentVacationStartedAt,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'level': level,
      'profile_url': profileUrl,
      'started_at': startedAt,
      'subscription': subscription.toMap(),
      'current_vacation_started_at': currentVacationStartedAt,
      'preferences': preferences.toMap(),
    };
  }

  factory WkUserData.fromMap(Map<String, dynamic> map) {
    return WkUserData(
      id: map['id'],
      username: map['username'],
      level: map['level'],
      profileUrl: map['profile_url'],
      startedAt: map['started_at'],
      subscription: WkUserSubscription.fromMap(map['subscription']),
      currentVacationStartedAt: map['current_vacation_started_at'],
      preferences: WkUserPreferences.fromMap(map['preferences']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WkUserData.fromJson(String source) =>
      WkUserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WkUserData(id: $id, username: $username, level: $level, profileUrl: $profileUrl, startedAt: $startedAt, subscription: $subscription, currentVacationStartedAt: $currentVacationStartedAt, preferences: $preferences)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WkUserData &&
        other.id == id &&
        other.username == username &&
        other.level == level &&
        other.profileUrl == profileUrl &&
        other.startedAt == startedAt &&
        other.subscription == subscription &&
        other.currentVacationStartedAt == currentVacationStartedAt &&
        other.preferences == preferences;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        level.hashCode ^
        profileUrl.hashCode ^
        startedAt.hashCode ^
        subscription.hashCode ^
        currentVacationStartedAt.hashCode ^
        preferences.hashCode;
  }
}
