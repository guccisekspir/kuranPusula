import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/globalWidgets/sizeWidget.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:screenshot/screenshot.dart';

class WillScreenShot extends StatefulWidget {
  final String imageURL;
  final ScreenshotController screenshotController;
  final Size currentImageInfo;
  const WillScreenShot(
      {Key? key, required this.imageURL, required this.screenshotController, required this.currentImageInfo})
      : super(key: key);

  @override
  State<WillScreenShot> createState() => _WillScreenShotState();
}

class _WillScreenShotState extends State<WillScreenShot> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();

  bool isSquare = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.currentImageInfo.height,
      width: widget.currentImageInfo.width,
      color: Colors.transparent,
      child: Stack(
        children: [
          Image.network(widget.imageURL),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: widget.currentImageInfo.height,
              width: widget.currentImageInfo.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: isSquare ? widget.currentImageInfo.height * 0.2 : widget.currentImageInfo.height * 0.2,
                      width: isSquare ? widget.currentImageInfo.width * 0.7 : widget.currentImageInfo.width * 0.7,
                      color: themeHelper.backgroundColor.withOpacity(0.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height:
                                isSquare ? widget.currentImageInfo.height * 0.2 : widget.currentImageInfo.height * 0.3,
                            width: widget.currentImageInfo.width * 0.2,
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
                              minWidth:
                                  isSquare ? widget.currentImageInfo.width * 0.5 : widget.currentImageInfo.width * 0.5,
                              maxWidth:
                                  isSquare ? widget.currentImageInfo.width * 0.5 : widget.currentImageInfo.width * 0.5,
                              maxHeight: isSquare
                                  ? widget.currentImageInfo.height * 0.15
                                  : widget.currentImageInfo.height * 0.05,
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
