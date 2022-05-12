import 'package:kuranpusula/model/beads.dart';

List<Beads> readyBeads = [
  Beads(
      id: null,
      bead: "Sübhanallahi velhamdülillâhi velâ ilâhe illallâhü vallâhü ekber",
      meaning: "Allah eksik sıfatlardan beridir. Hamd Allah’adır. Allah’tan başka ilah yoktur ve Allah en büyüktür.",
      prefCount: 100,
      beadedCount: 0,
      badges: [0, 3]),
  Beads(
      id: null,
      bead: "La İlahe İllallah",
      meaning: "Allah’dan başka ilah yoktur",
      prefCount: 120,
      beadedCount: 0,
      badges: [1, 2]),
  Beads(
      id: null,
      bead: "Hasbünallahü Ve Ni’melvekil",
      meaning: "Başka bir ilâh yok, ancak yedi semânın ve çok şerefli Arş’ın sahibi Allah var.",
      prefCount: 150,
      beadedCount: 0,
      badges: [2, 3])
];

Map<int, String> badgesMap = {
  0: "Sağlık",
  1: "Maddiyat",
  2: "Allah Rızası",
  3: "Huzur",
};

List<String> badgeIcons = [
  "assets/icons/health.png",
  "assets/icons/money.png",
  "assets/icons/allah.png",
  "assets/icons/peace.png",
];
