import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import "package:http/http.dart" as http;
import 'package:kuranpusula/globalWidgets/sizeWidget.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/pages/fridayImagesPage/widgets/willScreenShotWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

class FridayImageWidget extends StatefulWidget {
  final String imageURL;
  const FridayImageWidget({Key? key, required this.imageURL}) : super(key: key);

  @override
  State<FridayImageWidget> createState() => _FridayImageWidgetState();
}

class _FridayImageWidgetState extends State<FridayImageWidget> {
  Size? currentImageInfo;

  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();

  bool isSquare = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((Duration a) {
      Timer.periodic(Duration(milliseconds: 300), (timer) {
        if (mounted) {
          setState(() {});
        }
        if (timer.tick >= 10) {
          timer.cancel();
        }
      });
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Widget willScreenShotWidget = willCapture(currentImageInfo!);
        EasyLoading.show();

        await screenshotController.captureFromWidget(willScreenShotWidget).then((image) async {
          debugPrint("SS aldım");
          final directory = await getApplicationDocumentsDirectory();
          final file = await File('${directory.path}/temp.png').create();
          await file.writeAsBytes(image);
          debugPrint("yazım aldım");
          EasyLoading.dismiss();

          try {
            SocialShare.shareOptions("Kuran Pusula  Uygulaması'ndan", imagePath: file.path).then((data) {
              print(data);
            });
          } catch (e) {
            debugPrint(e.toString());
          }
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            color: Colors.red,
            child: Stack(
              children: [
                WidgetSize(
                    key: Key(widget.imageURL),
                    onChange: (Size size) {
                      if (size.height > size.width) {
                        setState(() {
                          isSquare = false;
                        });
                      }
                      setState(() {
                        currentImageInfo = size;
                      });
                    },
                    child: Image.network(widget.imageURL)),
                currentImageInfo != null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: currentImageInfo!.height,
                          width: currentImageInfo!.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: currentImageInfo!.height * 0.1,
                                width: currentImageInfo!.width,
                                color: themeHelper.primaryColor,
                                child: Center(
                                    child: AutoSizeText(
                                  "Paylaş",
                                  style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
                                )),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            )),
      ),
    );
  }

  Widget willCapture(Size currentImageInfo) {
    return Container(
      height: currentImageInfo.height,
      width: currentImageInfo.width,
      color: Colors.transparent,
      child: Stack(
        children: [
          Image.network(widget.imageURL),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: currentImageInfo.height,
              width: currentImageInfo.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: isSquare ? currentImageInfo.height * 0.2 : currentImageInfo.height * 0.2,
                      width: isSquare ? currentImageInfo.width * 0.7 : currentImageInfo.width * 0.7,
                      color: themeHelper.backgroundColor.withOpacity(0.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: isSquare ? currentImageInfo.height * 0.2 : currentImageInfo.height * 0.3,
                            width: currentImageInfo.width * 0.2,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Image.asset(
                                "assets/logo.png",
                                color: themeHelper.onBackgroundDark,
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: isSquare ? currentImageInfo.width * 0.5 : currentImageInfo.width * 0.5,
                              maxWidth: isSquare ? currentImageInfo.width * 0.5 : currentImageInfo.width * 0.5,
                              maxHeight: isSquare ? currentImageInfo.height * 0.15 : currentImageInfo.height * 0.05,
                            ),
                            child: AutoSizeText(
                              'Kuran Pusula',
                              style: themeHelper.titleTextStyleDark.copyWith(fontSize: sizeHelper.height! * 0.03),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
