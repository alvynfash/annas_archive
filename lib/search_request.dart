import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_request.freezed.dart';
part 'search_request.g.dart';

@freezed
class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    required String query,
    required bool useAdvanced,
    required String author,
    required bool epub,
    required bool pdf,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, Object?> json) =>
      _$SearchRequestFromJson(json);
}
