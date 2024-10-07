import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:http/http.dart' as http;
import 'package:reliable_interval_timer/reliable_interval_timer.dart';

ReliableIntervalTimer? timer;
const healthInterval = Duration(seconds: 90);
const apiAddress = 'https://www.anna-app.tribestick.com';

void init(InternetAddress ip, int port) {
  ReliableIntervalTimer(
    interval: healthInterval,
    callback: (elapsedMilliseconds) {
      http.get(Uri.parse('$apiAddress/health'));
    },
  ).start();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(handler, ip, port);
}
