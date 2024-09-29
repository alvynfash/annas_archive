import 'package:annas_archive/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_request.freezed.dart';
part 'search_request.g.dart';

@freezed
class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    required String query,
    required bool useAdvanced,
    required String author,
    @Default([]) List<Format> formats,
    @Default(20) int limit,
    @Default(Language.english) Language language,
    @Default([]) List<Content> contents,
    @Default(SortOption.mostRelevant) SortOption sort,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, Object?> json) =>
      _$SearchRequestFromJson(json);
}
