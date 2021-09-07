import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:wani_reminder/models/wk_element.dart';

class WkResponseData {
  final List<WkElement> lessons;
  final List<WkElement> reviews;
  final String nextReviewsAt;
  WkResponseData({
    required this.lessons,
    required this.reviews,
    required this.nextReviewsAt,
  });

  int lessonsCount() {
    var lessonsCount = 0;

    for (var lesson in lessons) {
      lessonsCount += lesson.subjectIds.length;
    }

    return lessonsCount;
  }

  int reviewCount() {
    var reviewCount = 0;

    final now = DateTime.now();
    final availableReviewsNow =
        reviews.where((element) => element.availableAt.isBefore(now)).toList();

    for (var review in availableReviewsNow) {
      reviewCount += review.subjectIds.length;
    }

    return reviewCount;
  }

  WkResponseData copyWith({
    List<WkElement>? lessons,
    List<WkElement>? reviews,
    String? nextReviewsAt,
  }) {
    return WkResponseData(
      lessons: lessons ?? this.lessons,
      reviews: reviews ?? this.reviews,
      nextReviewsAt: nextReviewsAt ?? this.nextReviewsAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessons': lessons.map((x) => x.toMap()).toList(),
      'reviews': reviews.map((x) => x.toMap()).toList(),
      'next_reviews_at': nextReviewsAt,
    };
  }

  factory WkResponseData.fromMap(Map<String, dynamic> map) {
    return WkResponseData(
      lessons: List<WkElement>.from(
          map['lessons']?.map((x) => WkElement.fromMap(x))),
      reviews: List<WkElement>.from(
          map['reviews']?.map((x) => WkElement.fromMap(x))),
      nextReviewsAt: map['next_reviews_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WkResponseData.fromJson(String source) =>
      WkResponseData.fromMap(json.decode(source));

  @override
  String toString() =>
      'WkResponseData(lessons: $lessons, reviews: $reviews, nextReviewsAt: $nextReviewsAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WkResponseData &&
        listEquals(other.lessons, lessons) &&
        listEquals(other.reviews, reviews) &&
        other.nextReviewsAt == nextReviewsAt;
  }

  @override
  int get hashCode =>
      lessons.hashCode ^ reviews.hashCode ^ nextReviewsAt.hashCode;
}
