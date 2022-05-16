import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/data/favoritesApiClient.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';
import 'package:kuranpusula/pages/beadsPage/consts/readyBeads.dart';
import 'package:kuranpusula/pages/beadsPage/subPages/newBeadsPage/widgets/newBeadWidget.dart';

class NewBeadsPage extends StatelessWidget {
  const NewBeadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    double containerHeight = sizeHelper.height! * 0.25;
    double containerWidth = sizeHelper.width! * 0.9;
    FavoritesApiClient favoritesApiClient = getIt<FavoritesApiClient>();
    return Container(
      height: sizeHelper.height,
      width: sizeHelper.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [themeHelper.secondaryColor, themeHelper.secondaryColor.withGreen(10)])),
      child: SafeArea(
        child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft, child: BackButton()),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: readyBeads.length,
                  itemBuilder: (context, index) {
                    Beads currentBeads = readyBeads[index];

                    return NewBeadWidget(currentBeads: currentBeads);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
