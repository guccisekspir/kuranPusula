import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';

class TodayVerseContainer extends StatelessWidget {
  const TodayVerseContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    double containerHeight = sizeHelper.height! * 0.15;
    double containerWidth = sizeHelper.width! * 0.9;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        height: containerHeight,
        width: containerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [
            themeHelper.primaryColor,
            themeHelper.primaryColor.withOpacity(0.4),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: Column(
          children: [
            SizedBox(
                height: containerHeight * 0.2,
                width: containerWidth * 0.8,
                child: AutoSizeText(
                  "Günün Ayeti",
                  textAlign: TextAlign.center,
                  style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: sizeHelper.height! * 0.01, horizontal: 10),
              child: SizedBox(
                  height: containerHeight * 0.6 - 10,
                  child: Center(
                    child: AutoSizeText(
                      "Hepiniz O'na yönelerek O'na karşı gelmekten sakının, namazı kılın; müşriklerden olmayın.",
                      textAlign: TextAlign.center,
                      style: themeHelper.subtitleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.02),
                    ),
                  )),
            ),
            const Expanded(
                child: AutoSizeText(
              "Rûm Sûresi(30) 31. Ayet",
              textAlign: TextAlign.center,
            ))
          ],
        ),
      ),
    );
  }
}
