import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';

class RequestPray extends StatefulWidget {
  const RequestPray({Key? key}) : super(key: key);

  @override
  State<RequestPray> createState() => _RequestPrayState();
}

class _RequestPrayState extends State<RequestPray> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: sizeHelper.height,
        width: sizeHelper.width,
        color: themeHelper.backgroundColor,
        child: SafeArea(
            child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft, child: BackButton()),
            SizedBox(
              height: sizeHelper.height! * 0.05,
              width: sizeHelper.width! * 0.8,
              child: AutoSizeText(
                "Dua İsteme Sayfası",
                textAlign: TextAlign.center,
                style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
              ),
            ),
            SizedBox(
              height: sizeHelper.height! * 0.05,
              width: sizeHelper.width! * 0.8,
              child: AutoSizeText(
                "Burada diğer insanlardan hayır duası isteyebilir veya diğer insaların isteklerini yerine getirebilirsiniz.",
                textAlign: TextAlign.center,
                style: themeHelper.subtitleTextStyleDark,
              ),
            ),
            const Spacer(),
            Center(
                child: Text(
              "Çok yakında bu sayfada dua isteklerinizi iletip dua alabileceksiniz!",
              style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
              textAlign: TextAlign.center,
            )),
            const Spacer(),

            // ElevatedButton(onPressed: () {}, child: Text("Dua İste")),
            /*   Container(
                  height: sizeHelper.height! * 0.15,
                  width: sizeHelper.width! * 0.9,
                  color: themeHelper.secondaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                          height: sizeHelper.height! * 0.075,
                          width: sizeHelper.width! * 0.9 * 0.9,
                          child: AutoSizeText(
                            "Çocuğum ameliyata girecek yarına kadar 50 tane yasin okursanız çok sevinirim",
                            textAlign: TextAlign.center,
                            style: themeHelper.titleTextStyleLight.copyWith(fontSize: sizeHelper.height! * 0.03),
                          )),
                      SizedBox(
                          height: sizeHelper.height! * 0.075,
                          width: sizeHelper.width! * 0.9 * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: sizeHelper.width! * 0.9 * 0.4,
                                child: AutoSizeText(
                                  "Kalan Miktar: 12",
                                  textAlign: TextAlign.center,
                                  style: themeHelper.titleTextStyleLight
                                      .copyWith(color: themeHelper.primaryColor, fontSize: sizeHelper.height! * 0.03),
                                ),
                              ),
                              ElevatedButton(onPressed: () {}, child: Text("Okumak için bas")),
                            ],
                          ))
                    ],
                  ),
                )*/
          ],
        )));
  }
}
