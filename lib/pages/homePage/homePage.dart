import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuranpusula/blocs/admobBloc/bloc/admob_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/pages/beadsPage/beadsPage.dart';
import 'package:kuranpusula/pages/fridayImagesPage/fridayImagePage.dart';
import 'package:kuranpusula/pages/homePage/widgets/beadsContainer.dart';
import 'package:kuranpusula/pages/homePage/widgets/todayVerseContainer.dart';
import 'package:kuranpusula/pages/qiblahPage/qiblahPage.dart';
import 'package:kuranpusula/pages/quranPage/quranPage.dart';
import 'package:kuranpusula/pages/requestPrayPage/requestPrayPage.dart';
import 'package:kuranpusula/pages/shareVersePage/shareVersePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    AdmobBloc admobBloc = getIt<AdmobBloc>();
    admobBloc.add(LoadIntersAd(DateTime.now()));
    return Container(
      height: sizeHelper.height,
      width: sizeHelper.width,
      color: themeHelper.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: sizeHelper.height! * 0.1,
                  child: Image.asset("assets/logo.png"),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: sizeHelper.width! * 0.5,
                    maxWidth: sizeHelper.width! * 0.5,
                    maxHeight: sizeHelper.height! * 0.1,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      'Kuran Pusula',
                      style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const TodayVerseContainer(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: MasonryGridView(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const BeadsPage()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.3,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Dua ve Zikir',
                        subtitle: 'Zikir yapmaya başla >.',
                        image: 'assets/icons/counter.png',
                        gradientColors: const [Color(0xff70b2d9), Color(0XFF39e5b6)],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const QuranPage()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.25,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Kuran',
                        subtitle: 'Ayetleri İncele >.',
                        image: 'assets/icons/quran.png',
                        gradientColors: const [Color(0XFFA182DF), Color(0xffDE99C0)],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ShareVersePage()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.2,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Ayet Paylaş',
                        subtitle: 'Sosyal Medyada ayet paylaş >.',
                        image: 'assets/icons/verse.png',
                        gradientColors: const [Color(0XFFdb3445), Color(0xfff71735)],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const FridayImagePage()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.2,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Cuma Sözleri',
                        subtitle: 'Birbirinden güzel sözler >.',
                        image: 'assets/icons/cuma.png',
                        gradientColors: const [Color(0XFFeb6b9d), Color(0xffee8c68)],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestPray()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.2,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Dua İste',
                        subtitle: 'Hayır için Dua oku,iste >.',
                        image: 'assets/icons/pray.png',
                        gradientColors: const [Color(0xff0652c5), Color(0XFF74f2ce)],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QiblahCompass()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.2,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Kıbleyi Bul',
                        subtitle: 'Kıblenizi bulun >.',
                        image: 'assets/icons/qibla.png',
                        gradientColors: const [Color(0XFFeb6b9d), Color(0xff36096d)],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
