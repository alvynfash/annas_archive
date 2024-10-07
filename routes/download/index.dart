import 'package:annas_archive_api/annas_archive_api.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final params = request.uri.queryParametersAll;

  final md5 = params['md5']?.firstOrNull ?? '';

  if (md5.isEmpty) {
    return Response(statusCode: 400, body: 'Missing required MD5 parameter');
  }

  // if (IsValid.validateChecksumMD5(md5)) {
  //   return Response(statusCode: 400, body: 'Invalid MD5');
  // }

  return AnnaApi().getDownloadLinks(md5).then((links) {
    if (links.isEmpty) {
      return Response(statusCode: 404, body: 'Download link not found');
    }

    return Response.json(body: links);
  }).catchError((e) {
    return Response(statusCode: 500, body: 'Error finding download link');
  });
}
