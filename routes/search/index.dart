import 'package:annas_archive/anna_api.dart';
import 'package:annas_archive/search_request.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (!request.uri.hasQuery) {
    return Response(statusCode: 400, body: 'Missing query parameters');
  }

  final params = request.uri.queryParameters;

  final searchTerm = params['q'] ?? '';
  // final lang = params['lang'] ?? 'en';
  final ext =
      BookExtensions.fromString(params['ext'] ?? BookExtensions.all.name);
  final author = params['author'] ?? '';
  // final fiction = bool.tryParse(params['fiction'].toString()) ?? false;
  // final nonfiction = bool.tryParse(params['nonfiction'].toString()) ?? false;

  final searchRequest = SearchRequest(
    query: searchTerm,
    useAdvanced: true,
    author: author,
    epub: ext == BookExtensions.epub || ext == BookExtensions.all,
    pdf: ext == BookExtensions.pdf || ext == BookExtensions.all,
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

enum BookExtensions {
  none(''),
  all('all'),
  pdf('pdf'),
  epub('epub');

  const BookExtensions(this.name);

  final String name;

  static BookExtensions fromString(String value) {
    if (value.contains(BookExtensions.pdf.name)) {
      return BookExtensions.pdf;
    }
    if (value.contains(BookExtensions.epub.name)) {
      return BookExtensions.epub;
    }
    if (value.contains(BookExtensions.all.name)) {
      return BookExtensions.all;
    }

    return BookExtensions.none;
  }
}
