import 'package:annas_archive_api/annas_archive_api.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final params = request.uri.queryParametersAll;

  final md5 = params['md5']?.firstOrNull ?? '';
  final memberKey = params['mk']?.firstOrNull ?? '';

  if (md5.isEmpty || memberKey.isEmpty) {
    return Response(
      statusCode: 400,
      body: 'Missing required parameters',
    );
  }

  // if (IsValid.validateChecksumMD5(md5)) {
  //   return Response(statusCode: 400, body: 'Invalid MD5');
  // }

  return AnnaApi()
      .getMemberDownloadLinks(md5: md5, membershipKey: memberKey)
      .then((result) {
    if (result == null) {
      return Response(
        statusCode: 404,
        body:
            'Error fetching member download link with submitted data, Check md5 and membership key and try again.',
      );
    }

    return Response.json(body: result);
  }).catchError((e) {
    return Response(
      statusCode: 500,
      body: 'Error fetching member download link',
    );
  });
}
