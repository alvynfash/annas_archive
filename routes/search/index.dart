import 'package:annas_archive/anna_api.dart';
import 'package:annas_archive/enums.dart';
import 'package:annas_archive/search_request.dart';
import 'package:dart_frog/dart_frog.dart';

int _defaultSearchLimit = 20;

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (!request.uri.hasQuery) {
    return Response(statusCode: 400, body: 'Missing query parameters');
  }

  final params = request.uri.queryParametersAll;

  final searchTerm = params['q']?.firstOrNull ?? '';
  final author = params['author']?.firstOrNull ?? '';
  final limit = params.containsKey('limit')
      ? int.tryParse(params['limit']!.first) ?? _defaultSearchLimit
      : _defaultSearchLimit;

  final language =
      Language.fromString(params['lang']?.firstOrNull ?? Language.english.code);

  final contents = params['content']
          ?.map(Content.fromString)
          .where((content) => content != Content.unknown)
          .toList() ??
      [];

  final formats = params['ext']
          ?.map(Format.fromString)
          .where((format) => format != Format.unknown)
          .toList() ??
      [];

  final sort = SortOption.fromString(
      params['sort']?.firstOrNull ?? SortOption.mostRelevant.value);

  final searchRequest = SearchRequest(
    query: searchTerm,
    useAdvanced: true,
    author: author,
    language: language,
    limit: limit,
    sort: sort,
    contents: contents.isNotEmpty ? contents : kAllContents,
    formats: formats.isNotEmpty ? formats : kAllFormats,
  );

  return AnnaApi().findAdvanced(searchRequest).then((result) {
    return Response.json(
      body: {
        'total': result.length,
        'results': result,
      },
    );
  }).catchError((e) {
    return Response(statusCode: 500, body: 'Error finding books');
  });
}

const kAllFormats = [
  Format.epub,
  Format.pdf,
  Format.azw3,
  Format.mobi,
];

const kAllContents = [
  Content.fiction,
  Content.nonfiction,
  Content.magazine,
  Content.comic,
];
