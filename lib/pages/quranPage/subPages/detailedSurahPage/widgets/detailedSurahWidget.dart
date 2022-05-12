import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/model/detailedSurah.dart';

class DetailedSurahWidget extends StatelessWidget {
  final Verse currentVerse;
  const DetailedSurahWidget({Key? key, required this.currentVerse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    double containerHeight = sizeHelper.height! * 0.2;
    double containerWidth = sizeHelper.width! * 0.9;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Container(
        height: containerHeight,
        color: themeHelper.surfaceColor,
        child: Column(
          children: [
            SizedBox(
              height: containerHeight * 0.3,
              width: containerWidth * 0.7,
              child: AutoSizeText(
                currentVerse.verse ?? "",
                textAlign: TextAlign.center,
                style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              height: containerHeight * 0.2,
              width: containerWidth * 0.9,
              child: AutoSizeText(
                currentVerse.transcription ?? "",
                textAlign: TextAlign.center,
                style: themeHelper.titleTextStyleDark
                    .copyWith(fontSize: sizeHelper.height! * 0.03, color: themeHelper.secondaryColor),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              height: containerHeight * 0.2,
              width: containerWidth * 0.8,
              child: AutoSizeText(
                currentVerse.translation?.text ?? "",
                textAlign: TextAlign.center,
                style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
