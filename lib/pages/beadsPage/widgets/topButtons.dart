import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';

class TopButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const TopButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeHelper themeHelper = ThemeHelper();
    SizeHelper sizeHelper = SizeHelper();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: sizeHelper.height! * 0.055,
        width: sizeHelper.width! * 0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: themeHelper.secondaryColor),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: AutoSizeText(
            title,
            maxLines: 1,
            style: themeHelper.titleTextStyleLight.copyWith(fontSize: sizeHelper.height! * 0.03),
          ),
        )),
      ),
    );
  }
}
