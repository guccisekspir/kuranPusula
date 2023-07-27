import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/data/quranApiClient.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';

class VerseDetailPage extends StatefulWidget {
  final Verse currentVerse;
  const VerseDetailPage({Key? key, required this.currentVerse})
      : super(key: key);

  @override
  State<VerseDetailPage> createState() => _VerseDetailPageState();
}

class _VerseDetailPageState extends State<VerseDetailPage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  late Translation? currentTranslations;
  List<Translation>? translationsList;
  QuranApiClient quranApiClient = getIt<QuranApiClient>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentTranslations = widget.currentVerse.translation;
    initAnan();
  }

  initAnan() async {
    translationsList = await quranApiClient.getTranslations(
        widget.currentVerse.surahId!, widget.currentVerse.verseNumber!);

    setState(() {
      translationsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    return Container(
      height: sizeHelper.height,
      width: sizeHelper.width,
      color: themeHelper.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft, child: BackButton()),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: sizeHelper.height! * 0.15,
                  minWidth: sizeHelper.width! * 0.9,
                  maxWidth: sizeHelper.width! * 0.9),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: AutoSizeText(
                  widget.currentVerse.verse ?? "",
                  textAlign: TextAlign.center,
                  style: themeHelper.titleTextStyleDark
                      .copyWith(fontSize: sizeHelper.height! * 0.1),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: sizeHelper.height! * 0.15,
                  minWidth: sizeHelper.width! * 0.9,
                  maxWidth: sizeHelper.width! * 0.9),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: AutoSizeText(
                  widget.currentVerse.transcription ?? "",
                  textAlign: TextAlign.center,
                  style: themeHelper.titleTextStyleDark
                      .copyWith(fontSize: sizeHelper.height! * 0.1),
                ),
              ),
            ),
            const Divider(),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: sizeHelper.height! * 0.15,
                  minWidth: sizeHelper.width! * 0.9,
                  maxWidth: sizeHelper.width! * 0.9),
              child: AutoSizeText(
                currentTranslations?.text ?? "",
                textAlign: TextAlign.center,
                style: themeHelper.titleTextStyleDark.copyWith(
                    fontSize: sizeHelper.height! * 0.02,
                    color: themeHelper.secondaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeHelper.width! * 0.25, vertical: 15),
              child: DropdownSearch<String>(
                items: translationsList
                        ?.map((e) => e.author?.name ?? "")
                        .toList() ??
                    [widget.currentVerse.translation?.author?.name ?? ""],
                onChanged: (String? e) {
                  if (e != null) {
                    setState(() {
                      currentTranslations = translationsList
                          ?.firstWhere((element) => element.author?.name == e);
                    });
                  }
                },
                selectedItem:
                    widget.currentVerse.translation?.author?.name ?? "",
              ),
            ),
            const Divider(),
            const Text("Kelimeler"),
          ],
        ),
      ),
    );
  }
}
