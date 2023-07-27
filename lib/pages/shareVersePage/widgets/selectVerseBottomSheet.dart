import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kuranpusula/blocs/quranBloc/bloc/quran_bloc.dart';
import 'package:kuranpusula/globalWidgets/buzzedWidget.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';
import 'package:kuranpusula/pages/quranPage/subPages/detailedSurahPage/detailedSurahPage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangeVerseBottomSheet extends StatefulWidget {
  final Surah selectedSurah;

  const ChangeVerseBottomSheet({Key? key, required this.selectedSurah})
      : super(key: key);

  @override
  State<ChangeVerseBottomSheet> createState() => _ChangeVerseBottomSheetState();
}

class _ChangeVerseBottomSheetState extends State<ChangeVerseBottomSheet> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  QuranBloc quranBloc = getIt<QuranBloc>();

  bool isFocused = false;

  List<Surah>? surahs;

  @override
  void initState() {
    // TODO: implement initState

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
          showTopSnackBar(Overlay.of(context),
              const CustomSnackBar.error(message: "Bir hata oluştu"));
        }
      },
      child: ClipRRect(
        child: BuzzedContainer(
          child: AnimatedContainer(
            height: sizeHelper.height! * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            duration: const Duration(milliseconds: 400),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: sizeHelper.height! * 0.075,
                      width: sizeHelper.width! * 0.8,
                      child: AutoSizeText("Hangi ayeti seçmek istersin?",
                          textAlign: TextAlign.center,
                          style: themeHelper.titleTextStyleLight.copyWith(
                            color: themeHelper.primaryColor,
                            fontSize: sizeHelper.height! * 0.06,
                          )),
                    ),
                  ),
                  DetailedSurahPage(
                    willFetchSurah: widget.selectedSurah,
                    isFromSheet: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
