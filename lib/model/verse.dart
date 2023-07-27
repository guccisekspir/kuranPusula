// To parse this JSON data, do
//
//     final verse = verseFromMap(jsonString);

import 'dart:convert';

class Verse {
  final Data? data;

  Verse({
    this.data,
  });

  factory Verse.fromJson(String str) => Verse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Verse.fromMap(Map<String, dynamic> json) => Verse(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class Data {
  final int? id;
  final int? surahId;
  final int? verseNumber;
  final int? charCount;
  final int? wordCount;
  final int? totalAbjad;
  final String? wordsAbjad;
  final String? wordCharsAbjad;
  final String? verse;
  final String? verseWithoutVowel;
  final String? transcription;
  final Translation? translation;

  Data({
    this.id,
    this.surahId,
    this.verseNumber,
    this.charCount,
    this.wordCount,
    this.totalAbjad,
    this.wordsAbjad,
    this.wordCharsAbjad,
    this.verse,
    this.verseWithoutVowel,
    this.transcription,
    this.translation,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        surahId: json["surah_id"],
        verseNumber: json["verse_number"],
        charCount: json["char_count"],
        wordCount: json["word_count"],
        totalAbjad: json["total_abjad"],
        wordsAbjad: json["words_abjad"],
        wordCharsAbjad: json["word_chars_abjad"],
        verse: json["verse"],
        verseWithoutVowel: json["verse_without_vowel"],
        transcription: json["transcription"],
        translation: json["translation"] == null
            ? null
            : Translation.fromMap(json["translation"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "surah_id": surahId,
        "verse_number": verseNumber,
        "char_count": charCount,
        "word_count": wordCount,
        "total_abjad": totalAbjad,
        "words_abjad": wordsAbjad,
        "word_chars_abjad": wordCharsAbjad,
        "verse": verse,
        "verse_without_vowel": verseWithoutVowel,
        "transcription": transcription,
        "translation": translation?.toMap(),
      };
}

class Translation {
  final int? id;
  final Author? author;
  final String? text;
  final List<Footnote>? footnotes;

  Translation({
    this.id,
    this.author,
    this.text,
    this.footnotes,
  });

  factory Translation.fromJson(String str) =>
      Translation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translation.fromMap(Map<String, dynamic> json) => Translation(
        id: json["id"],
        author: json["author"] == null ? null : Author.fromMap(json["author"]),
        text: json["text"],
        footnotes: json["footnotes"] == null
            ? []
            : List<Footnote>.from(
                json["footnotes"]!.map((x) => Footnote.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "author": author?.toMap(),
        "text": text,
        "footnotes": footnotes == null
            ? []
            : List<dynamic>.from(footnotes!.map((x) => x.toMap())),
      };
}

class Author {
  final int? id;
  final String? name;
  final String? description;
  final String? language;

  Author({
    this.id,
    this.name,
    this.description,
    this.language,
  });

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        language: json["language"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "language": language,
      };
}

class Footnote {
  final int? id;
  final int? number;
  final String? text;

  Footnote({
    this.id,
    this.number,
    this.text,
  });

  factory Footnote.fromJson(String str) => Footnote.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Footnote.fromMap(Map<String, dynamic> json) => Footnote(
        id: json["id"],
        number: json["number"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "number": number,
        "text": text,
      };
}
