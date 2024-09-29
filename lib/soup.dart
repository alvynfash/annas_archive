import 'package:beautiful_soup_dart/beautiful_soup.dart';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<BeautifulSoup> cookSoup(String url) async {
  final headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
  };
  var errorCount = 0;
  while (true) {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return BeautifulSoup(response.body);
    } else if (response.statusCode == 500) {
      errorCount += 1;
      // debugPrint("Internal Server Error! Retrying in 2 seconds...");
      await Future<void>.delayed(const Duration(seconds: 2));
    } else if (response.statusCode == 429) {
      errorCount += 1;
      // debugPrint("Moving too fast! Retrying in 10 seconds...");
      await Future<void>.delayed(const Duration(seconds: 10));
    } else {
      errorCount += 1;
      // debugPrint(
      //     "Failed to retrieve the page. Status code: ${response.statusCode}");
      await Future<void>.delayed(const Duration(seconds: 1));
    }

    if (errorCount == 5) {
      // debugPrint("Failed to retrieve the page after 5 attempts");
      throw Exception('Failed to retrieve the page after 5 attempts');
    }
  }
}
