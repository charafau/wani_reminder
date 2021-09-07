import 'dart:convert';

import 'package:collection/collection.dart';

class WkElement {
  final DateTime availableAt;
  final List<int> subjectIds;
  WkElement({
    required this.availableAt,
    required this.subjectIds,
  });

  WkElement copyWith({
    DateTime? availableAt,
    List<int>? subjectIds,
  }) {
    return WkElement(
      availableAt: availableAt ?? this.availableAt,
      subjectIds: subjectIds ?? this.subjectIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'available_at': availableAt,
      'subject_ids': subjectIds,
    };
  }

  factory WkElement.fromMap(Map<String, dynamic> map) {
    return WkElement(
      availableAt: DateTime.parse(map['available_at']),
      subjectIds: List<int>.from(map['subject_ids']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WkElement.fromJson(String source) =>
      WkElement.fromMap(json.decode(source));

  @override
  String toString() =>
      'WkElement(availableAt: $availableAt, subjectIds: $subjectIds)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WkElement &&
        other.availableAt == availableAt &&
        listEquals(other.subjectIds, subjectIds);
  }

  @override
  int get hashCode => availableAt.hashCode ^ subjectIds.hashCode;
}
