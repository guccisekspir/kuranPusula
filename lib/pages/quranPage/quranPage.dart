import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kuranpusula/blocs/admobBloc/bloc/admob_bloc.dart';
import 'package:kuranpusula/blocs/quranBloc/bloc/quran_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/surah.dart';
import 'package:kuranpusula/pages/quranPage/subPages/detailedSurahPage/detailedSurahPage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  QuranBloc quranBloc = getIt<QuranBloc>();

  List<Surah>? surahs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quranBloc.add(GetAllSurahs());
  }

  AdmobBloc admobBloc = getIt<AdmobBloc>();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Kuran",
      child: BlocListener<QuranBloc, QuranState>(
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
        child: Container(
          height: sizeHelper.height,
          width: sizeHelper.width,
          color: themeHelper.backgroundColor,
          child: SafeArea(
              child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    onPressed: () {
                      admobBloc.add(ShowIntersAd(DateTime.now()));
                      Navigator.pop(context);
                    },
                  )),
              Text(
                "Kuran Ayetleri",
                style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => DetailedSurahPage(willFetchSurah: currentSurah))));
                              },
                              child: Container(
                                height: sizeHelper.height! * 0.1,
                                width: sizeHelper.width! * 0.95,
                                color: themeHelper.backgroundColor,
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
                                                  color: themeHelper.onBackgroundLight),
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
                                          "Hemen Oku",
                                          style: themeHelper.titleTextStyleDark
                                              .copyWith(color: themeHelper.secondaryColor),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    ))
                  : const SizedBox()
            ],
          )),
        ),
      ),
    );
  }
}
