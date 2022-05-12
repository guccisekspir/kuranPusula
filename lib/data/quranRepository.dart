import 'package:kuranpusula/data/quranApiClient.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';

class QuranRepository {
  QuranApiClient quranApiClient = getIt<QuranApiClient>();

  List<Surah>? surahs;

  Future<List<Surah>> getSurahs() async {
    surahs ??= await quranApiClient.getSurahs();
    return surahs ?? [];
  }

  Future<DetailedSurah?> getDetailedSurah(int surahNumber) async {
    return await quranApiClient.getDetailedSurah(surahNumber);
  }
}
