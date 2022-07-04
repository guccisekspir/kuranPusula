import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kuranpusula/blocs/shareVerseBloc/bloc/share_verse_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/pages/quranPage/subPages/verseDetailPage/verseDetailPage.dart';

class DetailedSurahWidget extends StatelessWidget {
  final Verse currentVerse;
  final bool isFromSheet;

  const DetailedSurahWidget({Key? key, required this.currentVerse, this.isFromSheet = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    double containerHeight = sizeHelper.height! * 0.2;
    double containerWidth = sizeHelper.width! * 0.9;
    ShareVerseBloc shareVerseBloc = getIt<ShareVerseBloc>();
    return GestureDetector(
      onTap: () {
        if (isFromSheet) {
          GoRouter.of(context).pop();
          ;
          shareVerseBloc.add(VerseSelect(selectedVerse: currentVerse));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VerseDetailPage(currentVerse: currentVerse)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Container(
          height: containerHeight,
          color: themeHelper.surfaceColor,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: containerHeight * 0.08,
                  ),
                  SizedBox(
                    height: containerHeight * 0.35,
                    width: containerWidth * 0.7,
                    child: AutoSizeText(
                      currentVerse.verse ?? "",
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.1),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    height: containerHeight * 0.35,
                    width: containerWidth * 0.9,
                    child: AutoSizeText(
                      isFromSheet ? currentVerse.translation?.text ?? "" : currentVerse.transcription ?? "",
                      textAlign: TextAlign.center,
                      style: themeHelper.titleTextStyleDark
                          .copyWith(fontSize: sizeHelper.height! * 0.03, color: themeHelper.secondaryColor),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    height: containerHeight * 0.1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        isFromSheet ? "SEÇ" : "Ayrıntı için tıkla ->",
                        textAlign: TextAlign.center,
                        style: themeHelper.titleTextStyleDark
                            .copyWith(fontSize: sizeHelper.height! * 0.02, color: themeHelper.primaryColor),
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  currentVerse.verseNumber.toString(),
                  style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.04),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
