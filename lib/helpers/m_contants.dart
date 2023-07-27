import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

/// In this class we define the global Gap's which defined in Figma
class MConstants {
  factory MConstants() {
    return _mContants;
  }
  MConstants._internal();
  static final MConstants _mContants = MConstants._internal();
  int get schemaSupportedVersion => 1;

  BorderRadius get borderSmallRadius => BorderRadius.circular(12);

  BorderRadius get borderMediumRadius => BorderRadius.circular(16);

  BorderRadius get borderBigRadius => BorderRadius.circular(20);

  int get buttonNormalSpamDurationInMs => 600;
  int get buttonHighSpamDurationInMs => 3000;

  int totalSurahCount = 114;
}
