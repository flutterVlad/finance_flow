import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';

@freezed
abstract class Response with _$Response {
  const Response._();

  const factory Response({
    @Default('') String message,
    @Default(false) bool success,
  }) = _Response;

  Response changeSuccessMessage(String mes) =>
      success ? copyWith(message: mes) : this;
}
