import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Response(body: "Welcome to the unofficial Anna's Archive API !!");
}
