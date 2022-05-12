import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kuranpusula/blocs/quranBloc/bloc/quran_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';
import 'package:kuranpusula/pages/quranPage/subPages/detailedSurahPage/widgets/detailedSurahWidget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DetailedSurahPage extends StatefulWidget {
  final Surah willFetchSurah;
  const DetailedSurahPage({Key? key, required this.willFetchSurah}) : super(key: key);

  @override
  State<DetailedSurahPage> createState() => _DetailedSurahPageState();
}

class _DetailedSurahPageState extends State<DetailedSurahPage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();

  QuranBloc quranBloc = getIt<QuranBloc>();

  DetailedSurah? detailedSurah;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quranBloc.add(GetSurahDetails(surahId: widget.willFetchSurah.id!, dateTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuranBloc, QuranState>(
      bloc: quranBloc,
      listener: (context, state) {
        if (state is DetailedSurahLoading) {
          EasyLoading.show();
        } else if (state is DetailedSurahLoaded) {
          EasyLoading.dismiss();
          setState(() {
            detailedSurah = state.detailedSurah;
          });
        } else if (state is DetailedSurahLoadError) {
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
              Align(alignment: Alignment.centerLeft, child: BackButton()),
              Text(widget.willFetchSurah.name.toString() + " Suresi"),
              detailedSurah != null
                  ? Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: detailedSurah!.verses?.length ?? 0,
                          itemBuilder: ((context, index) {
                            Verse currentVerse = detailedSurah!.verses![index];
                            return DetailedSurahWidget(currentVerse: currentVerse);
                          })),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
