enum Source {
  anna,
  goodreadsProfile,
  goodreadsListopia,
  goodreadsSeries,
  unknown,
}

enum Format {
  // TODO(Alvyn): Add more formats
  unknown(''),
  mobi('mobi'),
  azw3('azw3'),
  pdf('pdf'),
  epub('epub');

  const Format(this.extension);

  final String extension;

  static Format fromString(String value) {
    if (value == Format.pdf.extension) {
      return Format.pdf;
    }
    if (value == Format.epub.extension) {
      return Format.epub;
    }

    if (value == Format.mobi.extension) {
      return Format.mobi;
    }

    if (value == Format.azw3.extension) {
      return Format.azw3;
    }

    return Format.unknown;
  }
}

enum Language {
  // TODO(Alvyn): Add more languages
  english('en'),
  french('fr'),
  german('de'),
  italian('it'),
  spanish('es');

  const Language(this.code);

  final String code;

  static Language fromString(String value) {
    if (value == Language.french.code) {
      return Language.french;
    }
    if (value == Language.german.code) {
      return Language.german;
    }
    if (value == Language.italian.code) {
      return Language.italian;
    }
    if (value == Language.spanish.code) {
      return Language.spanish;
    }

    return Language.english;
  }
}

enum SortOption {
  newest('newest'),
  oldest('oldest'),
  largest('largest'),
  smallest('smallest'),
  mostRelevant('');

  const SortOption(this.value);

  final String value;

  static SortOption fromString(String value) {
    if (value == SortOption.newest.value) {
      return SortOption.newest;
    }
    if (value == SortOption.oldest.value) {
      return SortOption.oldest;
    }
    if (value == SortOption.largest.value) {
      return SortOption.largest;
    }
    if (value == SortOption.smallest.value) {
      return SortOption.smallest;
    }

    return SortOption.mostRelevant;
  }
}

enum Content {
  // TODO(Alvyn): Add more content types
  unknown(''),
  fiction('fiction'),
  nonfiction('nonfiction'),
  comic('book_comic'),
  magazine('magazine');

  const Content(this.type);

  final String type;
  String get typeLowerCase => type.toLowerCase();

  static Content fromString(String value) {
    final lowerCaseValue = value.toLowerCase();

    if (lowerCaseValue == Content.comic.typeLowerCase) {
      return Content.comic;
    }
    if (lowerCaseValue == Content.fiction.typeLowerCase) {
      return Content.fiction;
    }
    if (lowerCaseValue == Content.magazine.typeLowerCase) {
      return Content.magazine;
    }
    if (lowerCaseValue == Content.nonfiction.typeLowerCase) {
      return Content.nonfiction;
    }

    return Content.unknown;
  }
}
