import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/pages/beadsPage/beadsPage.dart';
import 'package:kuranpusula/pages/homePage/widgets/beadsContainer.dart';
import 'package:kuranpusula/pages/homePage/widgets/todayVerseContainer.dart';
import 'package:kuranpusula/pages/quranPage/quranPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            ConstrainedBox(
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
            SizedBox(
              height: sizeHelper.height! * 0.1,
              child: Image.asset("assets/logo.png"),
            ),
            TodayVerseContainer(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BeadsPage()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.3,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Dua ve Zikir',
                        subtitle: 'Zikir yapmaya başla >.',
                        image: 'assets/icons/counter.png',
                        gradientColors: [Color(0xff70b2d9), Color(0XFF39e5b6)],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuranPage()));
                      },
                      child: HomeFeatureWidgets(
                        containerHeight: sizeHelper.height! * 0.25,
                        containerWidth: sizeHelper.width! * 0.4,
                        title: 'Kuran',
                        subtitle: 'Ayetleri İncele >.',
                        image: 'assets/icons/quran.png',
                        gradientColors: [Color(0XFFA182DF), Color(0xffDE99C0)],
                      ),
                    ),
                    HomeFeatureWidgets(
                      containerHeight: sizeHelper.height! * 0.2,
                      containerWidth: sizeHelper.width! * 0.4,
                      title: 'Ayet Paylaş',
                      subtitle: 'Sosyal Medyada ayet paylaş >.',
                      image: 'assets/icons/verse.png',
                      gradientColors: [Color(0XFFdb3445), Color(0xfff71735)],
                    ),
                    HomeFeatureWidgets(
                      containerHeight: sizeHelper.height! * 0.2,
                      containerWidth: sizeHelper.width! * 0.4,
                      title: 'Cuma Sözleri',
                      subtitle: 'Birbirinden güzel sözler >.',
                      image: 'assets/icons/cuma.png',
                      gradientColors: [Color(0XFFeb6b9d), Color(0xffee8c68)],
                    ),
                  ],
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
