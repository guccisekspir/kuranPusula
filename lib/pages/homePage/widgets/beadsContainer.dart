import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';

class HomeFeatureWidgets extends StatelessWidget {
  final String title, subtitle, image;
  final List<Color> gradientColors;
  final double containerHeight, containerWidth;

  const HomeFeatureWidgets(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.gradientColors,
      required this.containerHeight,
      required this.containerWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: gradientColors.first, blurRadius: 10, offset: Offset(0, 5))],
          gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: gradientColors)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: containerHeight * 0.3,
              width: containerHeight * 0.3,
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: containerHeight * 0.2, maxWidth: containerWidth * 0.95, minWidth: containerWidth * 0.95),
            child: AutoSizeText(
              title,
              textAlign: TextAlign.start,
              style: themeHelper.titleTextStyleLight.copyWith(fontSize: sizeHelper.height! * 0.03),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: containerHeight * 0.2, maxWidth: containerWidth * 0.95, minWidth: containerWidth * 0.95),
              child: AutoSizeText(
                subtitle,
                textAlign: TextAlign.start,
                style: themeHelper.subtitleTextStyleLight.copyWith(fontSize: sizeHelper.height! * 0.015),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
