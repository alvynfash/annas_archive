import 'package:annas_archive_api/annas_archive_api.dart';
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

  final cats = params['cat']
      ?.firstOrNull
      // ?.replaceAll('[', '')
      // .replaceAll(']', '')
      ?.replaceAll(' ', '')
      .split(',');

  final categories = cats
          ?.map(Category.fromString)
          .where((category) => category != Category.unknown)
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
    categories: categories.isNotEmpty ? categories : kAllCategories,
    formats: formats.isNotEmpty ? formats : kAllFormats,
  );

  return AnnaApi().find(searchRequest).then((result) {
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

const kAllCategories = [
  Category.fiction,
  Category.nonfiction,
  Category.magazine,
  Category.comic,
];
