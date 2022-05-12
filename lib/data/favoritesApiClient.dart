import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuranpusula/model/beads.dart';

class FavoritesApiClient {
  List<Beads> favorites = [];

  bool isFetched = false;

  Future<void> getFavorites() async {
    Box favoritesBox = await Hive.openBox<Beads>('favoriteBeads');
    if (favoritesBox.isNotEmpty) {
      Iterable<Beads> feedListe =
          favoritesBox.valuesBetween(startKey: 0, endKey: favoritesBox.keys.last) as Iterable<Beads>;
      favorites = feedListe.toList();
      debugPrint("Favoriler " + favorites.toString());
    } else {
      favorites = [];
    }
    isFetched = true;
  }

  bool isFavorited(Beads bead) {
    if (!isFetched) {
      getFavorites();
    }
    bool isFavorited = false;
    for (var element in favorites) {
      if (element.bead == bead.bead) {
        isFavorited = true;
        break;
      }
    }
    return isFavorited;
  }

  Future<void> saveFavorite(Beads bead) async {
    Box favoritesBox = await Hive.openBox<Beads>('favoriteBeads');
    if (favoritesBox.isEmpty) {
      bead.id = 0;
    } else {
      bead.id = favoritesBox.keys.last + 1;
    }
    debugPrint(bead.toString() + " favorilere eklenecek " + bead.id.toString());

    favoritesBox.add(bead);
    favorites.add(bead);
  }

  Future<void> unFavorite(Beads bead) async {
    Box favoritesBox = await Hive.openBox<Beads>('favoriteBeads');
    for (var element in favorites) {
      if (element.bead == bead.bead) {
        favoritesBox.delete(element.id);
        favorites.remove(element);
        break;
      }
    }
  }
}
