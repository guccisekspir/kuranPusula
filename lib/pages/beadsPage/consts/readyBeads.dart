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
      badges: [2, 3]),
  Beads(
      id: null,
      bead: "Bismillahi Subhanallahi ve Bihamdihi",
      meaning: "Allah’ın ismiyle başlayıp, Allah’ı tesbih ederim ve ona hamd ederim.",
      prefCount: 100,
      beadedCount: 0,
      badges: [0, 2]),
  Beads(
      id: null,
      bead: "Lâ ilâhe illallâhu vahdehu lâşerîke leh, lehu'l mülkü ve lehu'l hamdü ve hüve alâ külli şey'in kadîr",
      meaning:
          "Allah'tan başka hiçbir ilâh yoktur; o tektir, ortağı yoktur. Mülk onundur, hamd ona mahsustur ve o her şeye kàdirdir",
      prefCount: 120,
      beadedCount: 0,
      badges: [2, 3]),
  Beads(
      id: null,
      bead: "Lâ ilâhe illallâhu'l Melikül Hakkul Mübin",
      meaning: "Mülk sahibi Melik, hak ve varlığı birliği apaçık Mübin olan Allah'tan başka hiçbir ilah yoktu",
      prefCount: 110,
      beadedCount: 0,
      badges: [1, 2]),
  Beads(
      id: null,
      bead: "Sübhânallahi ve bihamdihî sübhânallahi’lazîm",
      meaning:
          "Ben Allah’ı ulûhiyyet makamına yakışmayan sıfatlardan tenzih eder ve O’na hamdederim. Ben Yüce Allah’ı ulûhiyyet makamına yakışmayan sıfatlardan tekrar tenzih ederim",
      prefCount: 150,
      beadedCount: 0,
      badges: [0, 2]),
  Beads(
      id: null,
      bead: "Sübhânallâhi velhamdülillâhi velâ ilâhe illallahü vallâhü ekber",
      meaning:
          "Allah eksik sıfatlardan münezzehtir. Hamd Allah'adır. Allah'tan başka ilah yoktur ve Allah en büyüktür.",
      prefCount: 200,
      beadedCount: 0,
      badges: [0, 3]),
  Beads(id: null, bead: "Estağfirullah", meaning: "İstiğfar.", prefCount: 50, beadedCount: 0, badges: [0, 2]),
  Beads(
      id: null,
      bead: "Subhanallahi ve bihamdihi adede halkıhi ve rıza nefsihi ve zinete arşihi ve midade kelimatihi",
      meaning: "Ben Allah’ı, O’nun rızasını kazanmak için kendisinin hoşnut olacağı sayıda tesbih ederim,.",
      prefCount: 50,
      beadedCount: 0,
      badges: [3, 2]),
  Beads(
      id: null,
      bead: "Allahumme ecirna minennar.",
      meaning: "Allah'ım, beni cehennem ateşinden koru",
      prefCount: 150,
      beadedCount: 0,
      badges: [3, 2]),
  Beads(
      id: null,
      bead: "Sübhânallahi ve bi–hamdihî sübhânallahi’l–azîm.",
      meaning: "Ben Allah’ı ulûhiyyet makamına yakışmayan sıfatlardan tenzih eder ve O’na hamdederim",
      prefCount: 150,
      beadedCount: 0,
      badges: [0, 2]),
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
