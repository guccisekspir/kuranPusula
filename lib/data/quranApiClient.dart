import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
}
