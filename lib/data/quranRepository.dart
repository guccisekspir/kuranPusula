import 'package:kuranpusula/data/quranApiClient.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';

class QuranRepository {
  QuranApiClient quranApiClient = getIt<QuranApiClient>();

  (String, String)? verseAndSurahName;

  List<Surah>? surahs;

  Future<List<Surah>> getSurahs() async {
    surahs ??= await quranApiClient.getSurahs();
    return surahs ?? [];
  }

  Future<DetailedSurah?> getDetailedSurah(int surahNumber) async {
    return await quranApiClient.getDetailedSurah(surahNumber);
  }

  Future<(String translation, String surahName)> getVerseAndSurahName(
      int surahNumber) async {
    if (verseAndSurahName != null) {
      return verseAndSurahName!;
    }
    verseAndSurahName = await quranApiClient.getVerseAndSurahName(surahNumber);
    return verseAndSurahName!;
  }
}
