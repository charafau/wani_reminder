import 'dart:convert';

class WkUserPreferences {
  final int lessonsBatchSize;
  final int defaultVoiceActorId;
  final bool lessonsAutoplayAudio;
  final bool reviewsAutoplayAudio;
  final String lessonsPresentationOrder;
  final bool reviewsDisplaySrsIndicator;

  WkUserPreferences({
    required this.lessonsBatchSize,
    required this.defaultVoiceActorId,
    required this.lessonsAutoplayAudio,
    required this.reviewsAutoplayAudio,
    required this.lessonsPresentationOrder,
    required this.reviewsDisplaySrsIndicator,
  });

  WkUserPreferences copyWith({
    int? lessonsBatchSize,
    int? defaultVoiceActorId,
    bool? lessonsAutoplayAudio,
    bool? reviewsAutoplayAudio,
    String? lessonsPresentationOrder,
    bool? reviewsDisplaySrsIndicator,
  }) {
    return WkUserPreferences(
      lessonsBatchSize: lessonsBatchSize ?? this.lessonsBatchSize,
      defaultVoiceActorId: defaultVoiceActorId ?? this.defaultVoiceActorId,
      lessonsAutoplayAudio: lessonsAutoplayAudio ?? this.lessonsAutoplayAudio,
      reviewsAutoplayAudio: reviewsAutoplayAudio ?? this.reviewsAutoplayAudio,
      lessonsPresentationOrder:
          lessonsPresentationOrder ?? this.lessonsPresentationOrder,
      reviewsDisplaySrsIndicator:
          reviewsDisplaySrsIndicator ?? this.reviewsDisplaySrsIndicator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lessons_batch_size': lessonsBatchSize,
      'default_voice_actor_id': defaultVoiceActorId,
      'lessons_autoplay_audio': lessonsAutoplayAudio,
      'reviews_autoplay_audio': reviewsAutoplayAudio,
      'lessons_presentation_order': lessonsPresentationOrder,
      'reviews_display_srs_indicator': reviewsDisplaySrsIndicator,
    };
  }

  factory WkUserPreferences.fromMap(Map<String, dynamic> map) {
    return WkUserPreferences(
      lessonsBatchSize: map['lessons_batch_size'],
      defaultVoiceActorId: map['default_voice_actor_id'],
      lessonsAutoplayAudio: map['lessons_autoplay_audio'],
      reviewsAutoplayAudio: map['reviews_autoplay_audio'],
      lessonsPresentationOrder: map['lessons_presentation_order'],
      reviewsDisplaySrsIndicator: map['reviews_display_srs_indicator'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WkUserPreferences.fromJson(String source) =>
      WkUserPreferences.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WkUserPreferences(lessonsBatchSize: $lessonsBatchSize, defaultVoiceActorId: $defaultVoiceActorId, lessonsAutoplayAudio: $lessonsAutoplayAudio, reviewsAutoplayAudio: $reviewsAutoplayAudio, lessonsPresentationOrder: $lessonsPresentationOrder, reviewsDisplaySrsIndicator: $reviewsDisplaySrsIndicator)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WkUserPreferences &&
        other.lessonsBatchSize == lessonsBatchSize &&
        other.defaultVoiceActorId == defaultVoiceActorId &&
        other.lessonsAutoplayAudio == lessonsAutoplayAudio &&
        other.reviewsAutoplayAudio == reviewsAutoplayAudio &&
        other.lessonsPresentationOrder == lessonsPresentationOrder &&
        other.reviewsDisplaySrsIndicator == reviewsDisplaySrsIndicator;
  }

  @override
  int get hashCode {
    return lessonsBatchSize.hashCode ^
        defaultVoiceActorId.hashCode ^
        lessonsAutoplayAudio.hashCode ^
        reviewsAutoplayAudio.hashCode ^
        lessonsPresentationOrder.hashCode ^
        reviewsDisplaySrsIndicator.hashCode;
  }
}
