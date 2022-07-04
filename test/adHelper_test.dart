import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuranpusula/helpers/adHelper.dart';

void main() {
  test("is iOS and Android adId same", () {
    AdHelper adHelper = AdHelper();
    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    debugPrint(Platform.operatingSystem);
    String androidIntersID = adHelper.intersAdUnitId;
    debugPrint(androidIntersID + "bu android");
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    String iosIntersID = adHelper.intersAdUnitId;
    debugPrint(iosIntersID + "bu ios");

    expect(iosIntersID, isNotEmpty);
  });
}
