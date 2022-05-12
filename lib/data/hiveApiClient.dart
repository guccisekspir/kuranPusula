import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuranpusula/model/beads.dart';

class HiveApiClient {
  Future<bool> saveBeadsToHive(Beads willSaveBead) async {
    try {
      Box beadsBox = await Hive.openBox<Beads>('beads');
      if (willSaveBead.id == null) {
        if (beadsBox.isEmpty) {
          debugPrint("DB'ye ilk kayıt");
          willSaveBead.id = 0;
          willSaveBead.createdTime = DateTime.now();
          beadsBox.add(willSaveBead);
        } else {
          debugPrint("DB'ye sonradan kayıt şu indexe : " + (beadsBox.keys.toList().last + 1).toString());

          List<Beads> savedBeads = await getSavedBeads();
          if (savedBeads.isEmpty) {
            willSaveBead.id = beadsBox.keys.toList().last + 1;
            willSaveBead.createdTime = DateTime.now();
            beadsBox.add(willSaveBead);
          } else {
            Beads? isAlreadySaved;
            for (var element in savedBeads) {
              if (element.bead == willSaveBead.bead) {
                isAlreadySaved = element;
              }
            }
            if (isAlreadySaved != null) {
              debugPrint("Zaten kaydedilmiş. update olaccak" + isAlreadySaved.id!.toString());
              beadsBox.putAt(isAlreadySaved.id!, isAlreadySaved);
            } else {
              willSaveBead.id = beadsBox.keys.toList().last + 1;
              willSaveBead.createdTime = DateTime.now();
              debugPrint("Box boş değil, kaydedilmemiş. update olaccak" + willSaveBead.id!.toString());

              beadsBox.add(willSaveBead);
            }
          }
        }
      } else {
        debugPrint("DB'ye kaydedilmiş update edilecek : " + willSaveBead.id.toString());

        willSaveBead.createdTime = DateTime.now();
        beadsBox.putAt(willSaveBead.id!, willSaveBead);
      }
      debugPrint(beadsBox.keys.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Beads>> getSavedBeads() async {
    Box feedsBox = await Hive.openBox<Beads>('beads');

    if (feedsBox.length >= 1) {
      Iterable<Beads> feedListe = feedsBox.valuesBetween(startKey: 0, endKey: feedsBox.keys.last) as Iterable<Beads>;

      feedListe.forEach((element) {
        debugPrint(element.id.toString());
      });

      return feedListe.toList();
    } else {
      debugPrint("user Box çekilecekti ama boş");
      return [];
    }
  }

  Future<Beads?> getLatestCachedFeeds() async {
    Box feedsBox = await Hive.openBox<Beads>('beads');

    if (feedsBox.isNotEmpty) {
      return (feedsBox.getAt(feedsBox.keys.last) as Beads);
    } else {
      return null;
    }
  }

  Future<bool> deleteBeadsFromHive(Beads willDeleteBead) async {
    Box feedsBox = await Hive.openBox<Beads>('beads');

    if (willDeleteBead.id != null) {
      debugPrint("E NUL DEĞİL SİLMESİ LAZIM");
      await feedsBox.deleteAt(willDeleteBead.id!);
    } else {
      debugPrint("E NUL BU");
    }

    return true;
  }
}
