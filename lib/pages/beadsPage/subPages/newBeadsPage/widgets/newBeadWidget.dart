import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/data/favoritesApiClient.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';
import 'package:kuranpusula/pages/beadsPage/consts/readyBeads.dart';

class NewBeadWidget extends StatefulWidget {
  final Beads currentBeads;
  const NewBeadWidget({Key? key, required this.currentBeads}) : super(key: key);

  @override
  State<NewBeadWidget> createState() => _NewBeadWidgetState();
}

class _NewBeadWidgetState extends State<NewBeadWidget> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  late double containerHeight;
  late double containerWidth;
  late bool isFavorited;
  FavoritesApiClient favoritesApiClient = getIt<FavoritesApiClient>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    containerHeight = sizeHelper.height! * 0.25;
    containerWidth = sizeHelper.width! * 0.9;
    isFavorited = favoritesApiClient.isFavorited(widget.currentBeads);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: containerHeight,
        width: containerWidth,
        decoration: BoxDecoration(color: themeHelper.backgroundColor, borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: containerHeight * 0.3,
                width: containerWidth * 0.9,
                child: AutoSizeText(
                  widget.currentBeads.bead!,
                  textAlign: TextAlign.center,
                  style: themeHelper.titleTextStyleDark.copyWith(fontSize: containerHeight * 0.1),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...widget.currentBeads.badges
                    .map((e) => Chip(
                          avatar: Image.asset(
                            badgeIcons[e],
                          ),
                          label: Text(badgesMap[e]!),
                        ))
                    .toList()
              ],
            ),
            const Spacer(),
            SizedBox(
              height: containerHeight * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                      opacity: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                          ))),
                  const Spacer(
                    flex: 3,
                  ),
                  SizedBox(
                      height: containerHeight * 0.3,
                      width: sizeHelper.width! * 0.4,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, widget.currentBeads);
                          },
                          child: const Text("Başlat"))),
                  const Spacer(
                    flex: 3,
                  ),
                  IconButton(
                      onPressed: () {
                        if (!isFavorited) {
                          favoritesApiClient.saveFavorite(widget.currentBeads);
                        } else {
                          favoritesApiClient.unFavorite(widget.currentBeads);
                        }
                        setState(() {
                          isFavorited = !isFavorited;
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorited ? Colors.red : themeHelper.onBackgroundDark,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
