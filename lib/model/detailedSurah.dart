// To parse this JSON data, do
//
//     final detailedSurah = detailedSurahFromMap(jsonString);

import 'dart:convert';

class DetailedSurah {
  DetailedSurah({
    this.id,
    this.name,
    this.slug,
    this.verseCount,
    this.audio,
    this.verses,
  });

  int? id;
  String? name;
  String? slug;
  int? verseCount;
  Audio? audio;
  List<Verse>? verses;

  factory DetailedSurah.fromJson(String str) => DetailedSurah.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailedSurah.fromMap(Map<String, dynamic> json) => DetailedSurah(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        verseCount: json["verse_count"] == null ? null : json["verse_count"],
        audio: json["audio"] == null ? null : Audio.fromMap(json["audio"]),
        verses: json["verses"] == null ? null : List<Verse>.from(json["verses"].map((x) => Verse.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "verse_count": verseCount == null ? null : verseCount,
        "audio": audio == null ? null : audio!.toMap(),
        "verses": verses == null ? null : List<dynamic>.from(verses!.map((x) => x.toMap())),
      };
}

class Audio {
  Audio({
    this.mp3,
    this.duration,
  });

  String? mp3;
  int? duration;

  factory Audio.fromJson(String str) => Audio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Audio.fromMap(Map<String, dynamic> json) => Audio(
        mp3: json["mp3"] == null ? null : json["mp3"],
        duration: json["duration"] == null ? null : json["duration"],
      );

  Map<String, dynamic> toMap() => {
        "mp3": mp3 == null ? null : mp3,
        "duration": duration == null ? null : duration,
      };
}

class Verse {
  Verse({
    this.id,
    this.surahId,
    this.verseNumber,
    this.verse,
    this.transcription,
    this.translation,
  });

  int? id;
  int? surahId;
  int? verseNumber;
  String? verse;
  String? transcription;
  Translation? translation;

  factory Verse.fromJson(String str) => Verse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Verse.fromMap(Map<String, dynamic> json) => Verse(
        id: json["id"] == null ? null : json["id"],
        surahId: json["surah_id"] == null ? null : json["surah_id"],
        verseNumber: json["verse_number"] == null ? null : json["verse_number"],
        verse: json["verse"] == null ? null : json["verse"],
        transcription: json["transcription"] == null ? null : json["transcription"],
        translation: json["translation"] == null ? null : Translation.fromMap(json["translation"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "surah_id": surahId == null ? null : surahId,
        "verse_number": verseNumber == null ? null : verseNumber,
        "verse": verse == null ? null : verse,
        "transcription": transcription == null ? null : transcription,
        "translation": translation == null ? null : translation!.toMap(),
      };
}

class TranslationList {
  TranslationList({
    this.translations,
  });

  List<Translation>? translations;

  factory TranslationList.fromJson(String str) => TranslationList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TranslationList.fromMap(Map<String, dynamic> json) => TranslationList(
        translations:
            json["data"] == null ? null : List<Translation>.from(json["data"].map((x) => Translation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": translations == null ? null : List<dynamic>.from(translations!.map((x) => x.toMap())),
      };
}

class Translation {
  Translation({
    this.id,
    this.author,
    this.text,
    this.footnotes,
  });

  int? id;
  Author? author;
  String? text;
  List<Footnote>? footnotes;

  factory Translation.fromJson(String str) => Translation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translation.fromMap(Map<String, dynamic> json) => Translation(
        id: json["id"] == null ? null : json["id"],
        author: json["author"] == null ? null : Author.fromMap(json["author"]),
        text: json["text"] == null ? null : json["text"],
        footnotes:
            json["footnotes"] == null ? null : List<Footnote>.from(json["footnotes"].map((x) => Footnote.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "author": author == null ? null : author!.toMap(),
        "text": text == null ? null : text,
        "footnotes": footnotes == null ? null : List<dynamic>.from(footnotes!.map((x) => x.toMap())),
      };
}

class Author {
  Author({
    this.id,
    this.name,
    this.description,
    this.language,
  });

  int? id;
  String? name;
  String? description;
  String? language;

  factory Author.fromJson(String str) => Author.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Author.fromMap(Map<String, dynamic> json) => Author(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "language": language == null ? null : language,
      };
}

class Footnote {
  Footnote({
    this.id,
    this.number,
    this.text,
  });

  int? id;
  int? number;
  String? text;

  factory Footnote.fromJson(String str) => Footnote.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Footnote.fromMap(Map<String, dynamic> json) => Footnote(
        id: json["id"] == null ? null : json["id"],
        number: json["number"] == null ? null : json["number"],
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "number": number == null ? null : number,
        "text": text == null ? null : text,
      };
}
