import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuranpusula/blocs/admobBloc/bloc/admob_bloc.dart';

import 'package:kuranpusula/blocs/shareVerseBloc/bloc/share_verse_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';
import 'package:kuranpusula/pages/shareVersePage/widgets/selectSurahBottomSheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class ShareVersePage extends StatefulWidget {
  const ShareVersePage({Key? key}) : super(key: key);

  @override
  State<ShareVersePage> createState() => _ShareVersePageState();
}

class _ShareVersePageState extends State<ShareVersePage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  AdmobBloc admobBloc = getIt<AdmobBloc>();

  Verse? selectedVerse;
  Surah? selectedSurah;
  ShareVerseBloc shareVerseBloc = getIt<ShareVerseBloc>();
  Surah currentSurah = Surah(name: "Fatiha");
  Verse currentVerse = Verse(
      verseNumber: 2,
      verse:
          "وَمِنْ آيَاتِهِ أَنْ خَلَقَ لَكُم مِّنْ أَنفُسِكُمْ أَزْوَاجًا لِّتَسْكُنُوا إِلَيْهَا وَجَعَلَ بَيْنَكُم مَّوَدَّةً وَرَحْمَةً إِنَّ فِي ذَلِكَ لَآيَاتٍ لِّقَوْمٍ يَتَفَكَّرُونَ",
      translation: Translation(
          text:
              "O'nun ayetlerinden biri de, sizin için kendi cinsinizden eşler yaratmasıdır. Siz, onunla dinginleşir huzur bulursunuz. Birbirinize karşı, aranızda sevgi ve rahmet oluşturdu. Düşünen bir toplum için bunda nice ayetler vardır."));

  bool isWillScreenShot = false;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShareVerseBloc, ShareVerseState>(
      bloc: shareVerseBloc,
      listener: (context, state) {
        if (state is VerseSelected) {
          setState(() {
            currentVerse = state.selectedVerse;
            currentSurah = state.selectedSurah;
          });
        }
      },
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          height: sizeHelper.height,
          width: sizeHelper.width,
          color: themeHelper.backgroundColor,
          child: Stack(
            children: [
              Container(
                height: sizeHelper.height,
                width: sizeHelper.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, themeHelper.onBackgroundDark],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight)),
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isWillScreenShot
                        ? SizedBox(height: sizeHelper.height! * 0.1, width: sizeHelper.width)
                        : const Align(alignment: Alignment.centerLeft, child: BackButton()),
                    GestureDetector(
                      onTap: () {
                        admobBloc.add(ShowIntersAd(DateTime.now()));
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: themeHelper.surfaceColor.withOpacity(0.3),
                            builder: (context) {
                              return const ChangeSurahBottomSheet(
                                selectedSurah: null,
                              );
                            });
                      },
                      child: SizedBox(
                        height: sizeHelper.height! * 0.15,
                        width: sizeHelper.width! * 0.8,
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: currentSurah.name,
                                style: TextStyle(
                                    fontSize: sizeHelper.height! * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: themeHelper.backgroundColor)),
                            TextSpan(
                                text: '\n',
                                style: TextStyle(
                                    fontSize: sizeHelper.height! * 0.03, color: themeHelper.onBackgroundDark)),
                            TextSpan(
                                text: currentVerse.verseNumber.toString() + '. Sure',
                                style: TextStyle(
                                    fontSize: sizeHelper.height! * 0.03,
                                    fontWeight: FontWeight.bold,
                                    color: themeHelper.backgroundColor)),
                            TextSpan(
                                text: '\n',
                                style: TextStyle(
                                    fontSize: sizeHelper.height! * 0.01, color: themeHelper.onBackgroundDark)),
                            TextSpan(
                                text: isWillScreenShot ? "" : 'Ayeti Değiştir',
                                style:
                                    TextStyle(fontSize: sizeHelper.height! * 0.03, color: themeHelper.secondaryColor)),
                          ]),
                          textAlign: TextAlign.center,
                          style: themeHelper.subtitleTextStyleLight.copyWith(fontSize: sizeHelper.height! * 0.03),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
                    SizedBox(
                      height: sizeHelper.height! * 0.1,
                      width: sizeHelper.width! * 0.9,
                      child: AutoSizeText(
                        currentVerse.verse ?? "",
                        textAlign: TextAlign.center,
                        style: themeHelper.titleTextStyleLight
                            .copyWith(fontSize: sizeHelper.height! * 0.2, color: themeHelper.backgroundColor),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      height: sizeHelper.height! * 0.15,
                      width: sizeHelper.width! * 0.9,
                      child: AutoSizeText(
                        currentVerse.translation?.text ?? "",
                        textAlign: TextAlign.center,
                        style: themeHelper.titleTextStyleLight
                            .copyWith(fontSize: sizeHelper.height! * 0.2, color: themeHelper.secondaryColor),
                      ),
                    ),
                    const Spacer(
                      flex: 6,
                    ),
                    Opacity(
                      opacity: isWillScreenShot ? 1 : 0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: sizeHelper.width! * 0.5,
                          maxWidth: sizeHelper.width! * 0.5,
                          maxHeight: sizeHelper.height! * 0.1,
                        ),
                        child: AutoSizeText(
                          'Kuran Pusula',
                          style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isWillScreenShot = false;
                        });
                      },
                      child: Opacity(
                        opacity: isWillScreenShot ? 1 : 0,
                        child: SizedBox(
                          height: sizeHelper.height! * 0.1,
                          child: Image.asset("assets/logo.png"),
                        ),
                      ),
                    ),
                    isWillScreenShot
                        ? SizedBox(height: sizeHelper.height! * 0.1, width: sizeHelper.width)
                        : const SizedBox(),
                  ],
                ),
              ),
              Opacity(
                opacity: isWillScreenShot ? 0 : 1,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isWillScreenShot = true;
                    });
                    await screenshotController.capture().then((image) async {
                      debugPrint("SS aldım");
                      final directory = await getApplicationDocumentsDirectory();
                      final file = await File('${directory.path}/temp.png').create();
                      await file.writeAsBytes(image!);
                      debugPrint("yazım aldım");

                      setState(() {
                        isWillScreenShot = false;
                      });

                      try {
                        SocialShare.shareOptions("Kuran Pusula  Uygulaması'ndan", imagePath: file.path).then((data) {
                          print(data);
                        });
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    });
                  },
                  child: SafeArea(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: sizeHelper.height! * 0.1,
                            width: sizeHelper.width! * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient:
                                    LinearGradient(colors: [themeHelper.secondaryColor, themeHelper.secondaryColor])),
                            child: Row(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  width: sizeHelper.width! * 0.2,
                                  child: AutoSizeText(
                                    "Paylaş",
                                    maxLines: 1,
                                    style: themeHelper.titleTextStyleLight
                                        .copyWith(color: themeHelper.primaryColor, fontSize: sizeHelper.height! * 0.03),
                                  ),
                                ),
                                Icon(
                                  Icons.share,
                                  color: themeHelper.primaryColor,
                                  size: sizeHelper.height! * 0.05,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
