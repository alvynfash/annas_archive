import 'package:annas_archive/anna_api.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:is_valid/is_valid.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final params = request.uri.queryParameters;

  if (!params.containsKey('md5')) {
    return Response(statusCode: 400, body: 'Missing required MD5 parameter');
  }

  final md5 = params['md5'] ?? '';

  if (IsValid.validateChecksumMD5(md5)) {
    return Response(statusCode: 400, body: 'Invalid MD5');
  }

  return AnnaApi().getLibGenLIDownloadLink(md5).then((link) {
    if (link == null) {
      return Response(statusCode: 404, body: 'Download link not found');
    }

    return Response.json(body: {
      'file': link,
    });
  }).catchError((e) {
    return Response(statusCode: 500, body: 'Error finding download link');
  });
}
