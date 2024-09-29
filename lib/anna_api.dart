import 'package:annas_archive/book.dart';
import 'package:annas_archive/enums.dart';
import 'package:annas_archive/search_request.dart';
import 'package:annas_archive/soup.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';

class AnnaApi {
  int? getAnnaResultCount(BeautifulSoup soup) {
    try {
      final count = soup
          .find('main', class_: 'main')
          ?.find('div', class_: 'flex w-full')
          ?.find('div', class_: 'min-w-[0] w-full')
          ?.find('div', class_: 'mt-4 uppercase text-xs text-gray-500')
          ?.text
          .trim()
          .split('(')[1]
          .trim()
          .split('total')[0]
          .replaceAll(' ', '');

      return int.tryParse(count!);
    } catch (e) {
      return null;
    }
  }

  Future<List<Book>> find(SearchRequest searchRequest) async {
    try {
      const baseUrl = 'https://annas-archive.org/search?index=&q=';
      final formattedQuery = searchRequest.query.replaceAll(' ', '+');
      final urlEnding = _getUrlEnding(searchRequest);

      final url = baseUrl + formattedQuery + urlEnding;

      final soup = await cookSoup(url);

      final resultCount = getAnnaResultCount(soup);
      if (resultCount == null || resultCount == 0) {
        return [];
      }

      final books = soup.findAll(
        'div',
        class_: 'h-[125px] flex flex-col justify-center',
        limit: resultCount < searchRequest.limit
            ? resultCount
            : searchRequest.limit,
      );

      return convertListToModelWithErrorCount<Book>(
        [...books],
        Book.fromAnna,
      ).results;
    } catch (e) {
      throw Exception('Error finding books');
    }
  }

  Future<List<Book>> findAdvanced(SearchRequest searchRequest) async {
    try {
      const baseUrl = 'https://annas-archive.org/search?index=&page=1&q=';
      final formattedQuery = searchRequest.query; //.replaceAll(' ', '+');

      final author = searchRequest.author.replaceAll(',', '');
      final authorQuery =
          '&termtype_1=author&termval_1=$author'; //.replaceAll(' ', '+');
      final urlEnding = _getUrlEnding(searchRequest);

      final url = baseUrl + formattedQuery + authorQuery + urlEnding;
      final soup = await cookSoup(Uri.encodeFull(url));
      final resultCount = getAnnaResultCount(soup);
      if (resultCount == null || resultCount == 0) {
        return [];
      }

      final books = soup.findAll(
        'div',
        class_: 'h-[125px] flex flex-col justify-center',
        limit: resultCount < searchRequest.limit
            ? resultCount
            : searchRequest.limit,
      );

      return convertListToModelWithErrorCount<Book>(
        [...books],
        Book.fromAnna,
      ).results;
    } catch (e) {
      throw Exception('Error finding books');
    }
  }

  String _getUrlEnding(SearchRequest searchRequest) {
    var urlEnding = '&acc=external_download&src=lgli';

    // Content
    if (searchRequest.contents.contains(Content.fiction)) {
      urlEnding += '&content=book_fiction';
    }

    if (searchRequest.contents.contains(Content.nonfiction)) {
      urlEnding += '&content=book_nonfiction';
    }

    if (searchRequest.contents.contains(Content.magazine)) {
      urlEnding += '&content=magazine';
    }

    if (searchRequest.contents.contains(Content.comic)) {
      urlEnding += '&content=book_comic';
    }

    // Formats
    if (searchRequest.formats.contains(Format.epub)) {
      urlEnding += '&ext=epub';
    }

    if (searchRequest.formats.contains(Format.pdf)) {
      urlEnding += '&ext=pdf';
    }

    if (searchRequest.formats.contains(Format.mobi)) {
      urlEnding += '&ext=mobi';
    }

    if (searchRequest.formats.contains(Format.azw3)) {
      urlEnding += '&ext=azw3';
    }

    return urlEnding +=
        '&lang=${searchRequest.language.code}&sort=${searchRequest.sort.value}';
  }

  Future<String?> getDownloadLink(Book book) async {
    return getLibGenLIDownloadLink(book.md5);
  }

  Future<String?> getLibGenLIDownloadLink(String md5) async {
    const cdnUrl = 'https://libgen.li/ads.php?md5=';
    final url = cdnUrl + md5;
    final soup = await cookSoup(url);
    final link = soup
        .find(
          'td',
          attrs: {
            'align': 'center',
            'valign': 'top',
            'bgcolor': '#A9F5BC',
          },
        )
        ?.find('a')
        ?.attributes['href'];

    return link != null ? 'https://libgen.li/$link' : null;
  }

  Future<List<Book>> getBookList(String listUrl) async {
    try {
      final result = linkChecker(listUrl);

      if (result.$1 == Source.unknown) {
        return [];
      }

      final soup = await cookSoup(result.$2);

      switch (result.$1) {
        case Source.goodreadsProfile:
          return getGoodreadsProfile(soup);

        default:
          return [];
      }
    } catch (e) {
      throw Exception('Error getting book list');
    }
  }

  (Source, String) linkChecker(String listUrl) {
    final regExp = RegExp(
      r'^((http|https|ftp):\/\/)?([a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?)$',
      caseSensitive: false,
    );

    if (regExp.hasMatch(listUrl)) {
      if (listUrl.contains('/review/')) {
        // int page = 1;
        // String formattedUrl = "$listUrl&page=$page&per_page=100";
        return (Source.goodreadsProfile, listUrl);
      } else if (listUrl.contains('/list/show')) {
        return (Source.goodreadsListopia, listUrl);
      } else if (listUrl.contains('/series/')) {
        return (Source.goodreadsSeries, listUrl);
      }
    }

    return (Source.unknown, '');
  }

  // Future<List> getGoodreadsListopiaList(BeautifulSoup soup) async {
  //   final bookCountContainer = soup.find("div", class_: "stacked");
  //   final bookString =
  //       bookCountContainer!.text.trim().split(' books')[0].trim();
  //   final bookCountString = bookString.replaceAll(",", "");
  //   int.parse(bookCountString);
  //   // final listName = soup.find("h1", class_: "gr-h1 gr-h1--serif")?.text.trim();

  //   return [];
  //   // final soup = await cookSoup(listUrl);
  //   // final booksHtml = soup.findAll('tr', class_: 'bookalike');

  //   // return booksHtml.map((html) => Book.fromGoodreads(html)).toList();
  // }

  Future<List<Book>> getGoodreadsProfile(BeautifulSoup soup) async {
    const resultLimit = 100;

    final books = soup.findAll(
      'tr',
      class_: 'bookalike review',
      limit: resultLimit,
    );

    return convertListToModelWithErrorCount<Book>(
      [...books],
      Book.fromProfile,
    ).results;
  }
}

// Parse List of model from List of Map with error count
ConversionResult<T> convertListToModelWithErrorCount<T>(
  List<Bs4Element> data,
  T Function(Bs4Element map) fromJson,
) {
  final results = <T>[];
  var errorCount = 0;

  for (final e in data) {
    try {
      results.add(fromJson(e));
    } catch (e) {
      errorCount++;
    }
  }

  return ConversionResult<T>(results, errorCount);
}

/// Class to return parsed list<T> with error count
class ConversionResult<T> {
  ConversionResult(this.results, this.errorCount);

  final List<T> results;
  final int errorCount;
}
