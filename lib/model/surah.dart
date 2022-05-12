// To parse this JSON data, do
//
//     final surahList = surahListFromMap(jsonString);

import 'dart:convert';

class SurahList {
  SurahList({
    this.surahs,
  });

  List<Surah>? surahs;

  factory SurahList.fromJson(String str) => SurahList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SurahList.fromMap(Map<String, dynamic> json) => SurahList(
        surahs: json["data"] == null ? null : List<Surah>.from(json["data"].map((x) => Surah.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": surahs == null ? null : List<dynamic>.from(surahs!.map((x) => x.toMap())),
      };
}

class Surah {
  Surah({
    this.id,
    this.name,
    this.slug,
    this.verseCount,
  });

  int? id;
  String? name;
  String? slug;
  int? verseCount;

  factory Surah.fromJson(String str) => Surah.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        slug: json["slug"] == null ? null : json["slug"],
        verseCount: json["verse_count"] == null ? null : json["verse_count"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "slug": slug == null ? null : slug,
        "verse_count": verseCount == null ? null : verseCount,
      };
}
