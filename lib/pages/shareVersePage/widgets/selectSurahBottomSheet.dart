import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:kuranpusula/blocs/quranBloc/bloc/quran_bloc.dart';
import 'package:kuranpusula/blocs/shareVerseBloc/bloc/share_verse_bloc.dart';
import 'package:kuranpusula/globalWidgets/buzzedWidget.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/surah.dart';
import 'package:kuranpusula/pages/shareVersePage/widgets/selectVerseBottomSheet.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangeSurahBottomSheet extends StatefulWidget {
  final Surah? selectedSurah;

  const ChangeSurahBottomSheet({
    Key? key,
    required this.selectedSurah,
  }) : super(key: key);

  @override
  State<ChangeSurahBottomSheet> createState() => _ChangeSurahBottomSheetState();
}

class _ChangeSurahBottomSheetState extends State<ChangeSurahBottomSheet> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  QuranBloc quranBloc = getIt<QuranBloc>();
  ShareVerseBloc shareVerseBloc = getIt<ShareVerseBloc>();

  bool isFocused = false;

  List<Surah>? surahs;

  @override
  void initState() {
    // TODO: implement initState
    if (quranBloc.surahList != null && quranBloc.surahList!.isNotEmpty) {
      surahs = quranBloc.surahList;
    } else {
      quranBloc.add(GetAllSurahs());
    }
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        isFocused = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuranBloc, QuranState>(
      bloc: quranBloc,
      listener: (context, state) {
        if (state is SurahLoading) {
          EasyLoading.show();
        } else if (state is SurahLoaded) {
          EasyLoading.dismiss();
          setState(() {
            surahs = state.surahs;
          });
        } else if (state is SurahLoadError) {
          EasyLoading.dismiss();
          showTopSnackBar(context, const CustomSnackBar.error(message: "Bir hata oluştu"));
        }
      },
      child: ClipRRect(
        child: BuzzedContainer(
          child: AnimatedContainer(
            height: MediaQuery.of(context).viewInsets.bottom > 0 ? sizeHelper.height! * 0.8 : sizeHelper.height! * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            duration: const Duration(milliseconds: 400),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: sizeHelper.height! * 0.075,
                    width: sizeHelper.width! * 0.8,
                    child: AutoSizeText("Hangi Ayet'ten Paylaşmak İstiyorsun?",
                        textAlign: TextAlign.center,
                        style: themeHelper.titleTextStyleLight.copyWith(
                          color: themeHelper.primaryColor,
                          fontSize: sizeHelper.height! * 0.06,
                        )),
                  ),
                ),
                surahs != null
                    ? Expanded(
                        child: ListView.builder(
                        itemCount: surahs!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Surah currentSurah = surahs![index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  shareVerseBloc.add(SurahSelect(selectedSurah: currentSurah));
                                  GoRouter.of(context).pop();

                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: themeHelper.surfaceColor.withOpacity(0.3),
                                      builder: (context) {
                                        return ChangeVerseBottomSheet(
                                          selectedSurah: currentSurah,
                                        );
                                      });
                                },
                                child: BuzzedContainer(
                                  child: Container(
                                    height: sizeHelper.height! * 0.1,
                                    width: sizeHelper.width! * 0.95,
                                    color: themeHelper.backgroundColor.withOpacity(0.3),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: sizeHelper.height! * 0.1,
                                          width: sizeHelper.width! * 0.2,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage("assets/icons/surah.png"), fit: BoxFit.scaleDown)),
                                          child: Center(
                                            child: Text(currentSurah.id.toString()),
                                          ),
                                        ),
                                        SizedBox(
                                          height: sizeHelper.height! * 0.1,
                                          width: sizeHelper.width! * 0.5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: sizeHelper.height! * 0.1 * 0.3,
                                                child: AutoSizeText(
                                                  currentSurah.name!,
                                                  style: themeHelper.titleTextStyleDark.copyWith(
                                                      fontSize: sizeHelper.height! * 0.03,
                                                      color: themeHelper.onPrimary),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: sizeHelper.height! * 0.1 * 0.2,
                                                  child: AutoSizeText(
                                                    "Ayet Sayısı :" + currentSurah.verseCount!.toString(),
                                                    style: themeHelper.subtitleTextStyleDark,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: SizedBox(
                                            height: sizeHelper.height! * 0.1,
                                            width: sizeHelper.width! * 0.2,
                                            child: Center(
                                                child: AutoSizeText(
                                              "Seç",
                                              style: themeHelper.titleTextStyleDark
                                                  .copyWith(color: themeHelper.secondaryColor),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          );
                        },
                      ))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
