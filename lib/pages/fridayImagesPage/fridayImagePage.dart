import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuranpusula/helpers/listHelper.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/pages/fridayImagesPage/widgets/fridayImageWidget.dart';

class FridayImagePage extends StatefulWidget {
  const FridayImagePage({Key? key}) : super(key: key);

  @override
  State<FridayImagePage> createState() => _FridayImagePageState();
}

class _FridayImagePageState extends State<FridayImagePage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  List<List<String>> imagesList = [fridayImageLinks, niceWordsImageLinks, hadisImageLinks, sacrificialImageLinks];
  List<String> selectedImagesList = fridayImageLinks;
  List<String> labelNames = ["Cuma Sözleri", "Güzel Sözler", "Hadisler", "Kurban Bayramı"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeHelper.height! * fridayImageLinks.length,
      width: sizeHelper.width,
      color: themeHelper.backgroundColor,
      child: SafeArea(
          child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: BackButton(),
          ),
          AutoSizeText("İstediğin Resmi Paylaş",
              style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
              textAlign: TextAlign.center),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeHelper.width! * 0.2),
            child: DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              items: labelNames,
              dropdownSearchDecoration: InputDecoration(
                labelText: "Ne paylaşacaksın ?",
              ),
              popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (String? e) {
                if (e != null) {
                  setState(() {
                    selectedImagesList = imagesList[labelNames.indexOf(e)];
                  });
                  Timer.periodic(Duration(milliseconds: 300), (timer) {
                    if (mounted) {
                      setState(() {});
                    }
                    if (timer.tick >= 10) {
                      timer.cancel();
                    }
                  });
                }
              },
              selectedItem: "Cuma Sözleri",
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MasonryGridView(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    children: selectedImagesList.map((e) => FridayImageWidget(imageURL: e)).toList(),
                  )))
        ],
      )),
    );
  }
}
