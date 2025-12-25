import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurrence.freezed.dart';
part 'recurrence.g.dart';

enum RecurrenceType {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('yearly')
  yearly,
}

@freezed
abstract class Recurrence with _$Recurrence {
  const Recurrence._();

  const factory Recurrence({
    required RecurrenceType type,
    @Default(-1) int interval,
    required DateTime endTime,
  }) = _Recurrence;

  factory Recurrence.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceFromJson(json);
}
