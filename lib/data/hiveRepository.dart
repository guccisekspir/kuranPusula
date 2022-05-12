import 'package:kuranpusula/data/hiveApiClient.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';

class HiveRepository {
  HiveApiClient _hiveApiClient = getIt<HiveApiClient>();

  Future<bool> saveBeadsToHive(Beads beads) async {
    return await _hiveApiClient.saveBeadsToHive(beads);
  }

  Future<List<Beads>> getSavedBeads() async {
    return await _hiveApiClient.getSavedBeads();
  }

  Future<Beads?> getLatestCachedFeeds() async {
    return await _hiveApiClient.getLatestCachedFeeds();
  }

  Future<bool> deleteBeadsFromHive(Beads beads) async {
    return await _hiveApiClient.deleteBeadsFromHive(beads);
  }
}
