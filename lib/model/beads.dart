import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'beads.g.dart';

@HiveType(typeId: 0)
class Beads {
  Beads(
      {this.id,
      this.bead,
      this.meaning,
      this.prefCount,
      required this.beadedCount,
      this.createdTime,
      required this.badges});

  @override
  String toString() {
    return "id:$id bead:$bead meaning:$meaning prefCount:$prefCount beadedCount:$beadedCount";
  }

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? bead;
  @HiveField(2)
  String? meaning;
  @HiveField(3)
  int? prefCount;
  @HiveField(4)
  int beadedCount;
  @HiveField(5)
  DateTime? createdTime;
  @HiveField(6)
  List<int> badges;

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    if (other.createdTime == null) {
      return 1;
    } else {
      return other.createdTime!.compareTo(createdTime!);
    }
  }

  factory Beads.fromJson(String str) => Beads.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Beads.fromMap(Map<String, dynamic> json) => Beads(
        id: json["id"] == null ? null : json["id"],
        bead: json["bead"] == null ? null : json["bead"],
        meaning: json["meaning"] == null ? null : json["meaning"],
        prefCount: json["prefCount"] == null ? null : json["prefCount"],
        beadedCount: json["beadedCount"] == null ? null : json["beadedCount"],
        createdTime: json["createdTime"] == null
            ? DateTime.now()
            : (json["createdTime"]).toDate(), //todo firestore
        badges: json["badges"] == null
            ? [0]
            : List<int>.from(json["badges"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "bead": bead == null ? null : bead,
        "meaning": meaning == null ? null : meaning,
        "prefCount": prefCount == null ? null : prefCount,
        "beadedCount": beadedCount == null ? null : beadedCount,
        "createdTime": createdTime == null
            ? DateTime.now()
            : DateTime.now(), //Timestamp.fromDate(createdTime!),
        "badges":
            badges == null ? null : List<dynamic>.from(badges.map((x) => x)),
      };
}
