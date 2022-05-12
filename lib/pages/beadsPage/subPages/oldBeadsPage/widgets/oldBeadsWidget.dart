import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/blocs/beadsBloc/bloc/beads_bloc.dart';
import 'package:kuranpusula/data/favoritesApiClient.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';
import 'package:kuranpusula/pages/beadsPage/consts/readyBeads.dart';

class OldBeadWidget extends StatefulWidget {
  final Beads currentBeads;
  const OldBeadWidget({Key? key, required this.currentBeads}) : super(key: key);

  @override
  State<OldBeadWidget> createState() => _OldBeadWidgetState();
}

class _OldBeadWidgetState extends State<OldBeadWidget> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  late double containerHeight;
  late double containerWidth;
  late bool isFavorited;
  FavoritesApiClient favoritesApiClient = getIt<FavoritesApiClient>();

  BeadsBloc beadsBloc = getIt<BeadsBloc>();

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
        decoration: BoxDecoration(color: themeHelper.secondaryColor, borderRadius: BorderRadius.circular(30)),
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
            Container(
              height: containerHeight * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                      opacity: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                          ))),
                  const Spacer(
                    flex: 3,
                  ),
                  SizedBox(
                      height: containerHeight * 0.3,
                      width: sizeHelper.width! * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, widget.currentBeads);
                          },
                          child: Text("Devam Et"))),
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
