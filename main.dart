import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:http/http.dart' as http;

Timer? timer;
const healthInterval = Duration(minutes: 1);

Future<void> init(InternetAddress ip, int port) async {
  timer?.cancel();
  timer = Timer.periodic(
    healthInterval,
    (Timer t) {
      http.get(Uri.parse('https://annas-archive.globeapp.dev/health'));
    },
  );
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
