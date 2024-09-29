import 'package:annas_archive/enums.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String title,
    required String author,
    required String md5,
    required String imgUrl,
    required String size,
    required String genre,
    required Format format,
  }) = _Book;

  factory Book.fromAnna(Bs4Element soupElement) {
    bool hasIssue(BeautifulSoup soup) {
      return soup
          .findAll(
            'div',
            class_: 'text-xs lg:text-sm',
          )
          .isNotEmpty;
    }

    String getAuthor(BeautifulSoup soup) {
      return soup
          .find(
            'div',
            class_:
                'max-lg:line-clamp-[2] lg:truncate leading-[1.2] lg:leading-[1.35] max-lg:text-sm italic',
          )!
          .string;
    }

    String getTitle(BeautifulSoup soup) {
      return soup.h3!.string;
    }

    String getImageUrl(BeautifulSoup soup) {
      return soup.img!.attributes['src']!;
    }

    String getMd5(BeautifulSoup soup) {
      return soup.a!.attributes['href']!.split('/')[2];
    }

    List<String> getSplitMetadata(BeautifulSoup soup) {
      return soup
          .find(
            'div',
            class_:
                'line-clamp-[2] leading-[1.2] text-[10px] lg:text-xs text-gray-500',
          )!
          .string
          .split(',');
    }

    String getSize(List<String> splitMetadata) {
      return splitMetadata[3].trim();
    }

    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    String getGenre(List<String> splitMetadata) {
      return capitalize(splitMetadata[4]
          .replaceAll('(', '')
          .replaceAll(')', '')
          .split(' ')
          .last);
    }

    String getUncommentedHtml(Bs4Element soupElement) {
      return soupElement.outerHtml.replaceAll('<!--', '').replaceAll('-->', '');
    }

    Format getFormat(List<String> splitMetadata) {
      return Format.fromString(splitMetadata[1].trim().replaceAll('.', ''));
    }

    final soup = BeautifulSoup(getUncommentedHtml(soupElement));

    if (hasIssue(soup)) {
      throw Exception('Issue with book');
    }

    final splitMetadata = getSplitMetadata(soup);

    return Book(
      title: getTitle(soup),
      imgUrl: getImageUrl(soup),
      md5: getMd5(soup),
      size: getSize(splitMetadata),
      genre: getGenre(splitMetadata),
      format: getFormat(splitMetadata),
      author: getAuthor(soup),
    );
  }

  factory Book.fromProfile(Bs4Element soupElement) {
    String getAuthor() {
      return soupElement
          .find(
            'td',
            class_: 'field author',
          )!
          .a!
          .text;
    }

    String getTitle() {
      return soupElement
          .find(
            'td',
            class_: 'field title',
          )!
          .a!
          .attributes['title']!;
    }

    String getImageUrl() {
      return soupElement
          .find(
            'div',
            class_: 'js-tooltipTrigger tooltipTrigger',
          )!
          .img!
          .attributes['src']!
          .replaceAll('_SX50_', '_SX400_');
    }

    String getIsbn() {
      return soupElement
          .find(
            'td',
            class_: 'field isbn',
          )!
          .element!
          .text
          .replaceAll('isbn', '')
          .replaceAll(' ', '');
    }

    return Book(
      title: getTitle(),
      imgUrl: getImageUrl(),
      md5: getIsbn(),
      size: 'unknown size',
      genre: '',
      author: getAuthor(),
      format: Format.unknown,
    );
  }

  factory Book.fromJson(Map<String, Object?> json) => _$BookFromJson(json);
}
