import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';

class QuranApiClient {
  BaseOptions getBaseOption() {
    return BaseOptions(baseUrl: "https://api.acikkuran.com/");
  }

  Future<List<Surah>> getSurahs() async {
    List<Surah> surahs = [];

    Dio dio = Dio(getBaseOption());

    try {
      Response response = await dio.get('surahs');

      surahs = SurahList.fromJson(jsonEncode(response.data)).surahs ?? [];
      return surahs;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }

    return [];
  }

  Future<DetailedSurah?> getDetailedSurah(int surahNumber) async {
    Dio dio = Dio(getBaseOption());

    try {
      Response response = await dio.get('surah/$surahNumber');

      DetailedSurah detailedSurahs = DetailedSurah.fromJson(jsonEncode(response.data["data"]));
      return detailedSurahs;
    } on DioError catch (error) {
      debugPrint(error.toString());
    }

    return DetailedSurah();
  }

  Future<List<Translation>> getTranslations(int surahID, int verseID) async {
    debugPrint("surah" + surahID.toString() + " verse" + verseID.toString());
    Dio dio = Dio(getBaseOption());

    Response response = await dio.get('surah/$surahID/verse/$verseID/translations');
    return TranslationList.fromJson(jsonEncode(response.data)).translations ?? [];
  }
}
