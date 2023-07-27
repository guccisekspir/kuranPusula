import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:kuranpusula/blocs/admobBloc/bloc/admob_bloc.dart';
import 'package:kuranpusula/blocs/beadsBloc/bloc/beads_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';
import 'package:kuranpusula/pages/beadsPage/consts/readyBeads.dart';
import 'package:kuranpusula/pages/beadsPage/subPages/newBeadsPage/newBeadsPage.dart';
import 'package:kuranpusula/pages/beadsPage/subPages/oldBeadsPage/oldBeadsPage.dart';
import 'package:kuranpusula/pages/beadsPage/widgets/topButtons.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BeadsPage extends StatefulWidget {
  const BeadsPage({Key? key}) : super(key: key);

  @override
  State<BeadsPage> createState() => _BeadsPageState();
}

class _BeadsPageState extends State<BeadsPage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  int counter = 0;
  BeadsBloc beadsBloc = getIt<BeadsBloc>();
  Beads? currentBeads;
  AdmobBloc admobBloc = getIt<AdmobBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    beadsBloc.add(GetUserBeads());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BeadsBloc, BeadsState>(
      bloc: beadsBloc,
      listener: (context, state) {
        if (state is BeadsLoading) {
          EasyLoading.show();
        } else if (state is BeadsLoaded) {
          EasyLoading.dismiss();
          debugPrint(
              "loaded state " + state.beads.length.toString() + " length");
          if (state.beads.isEmpty) {
            setState(() {
              currentBeads = readyBeads[0];
            });
          } else {
            setState(() {
              currentBeads = state.beads.first;
            });
          }
        } else if (state is BeadsLoadError) {
          EasyLoading.dismiss();
          showTopSnackBar(Overlay.of(context),
              const CustomSnackBar.error(message: "Bir Hata Oluştu"));
          setState(() {
            currentBeads = readyBeads[0];
          });
        } else if (state is SelectedBeadsFetched) {
          EasyLoading.dismiss();
          setState(() {
            currentBeads = state.hiveSavedBead;
          });
        }
      },
      child: Scaffold(
        body: Hero(
          tag: 'Dua ve Zikir',
          child: Container(
            height: sizeHelper.height!,
            width: sizeHelper.width!,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xff70b2d9), Color(0XFF39e5b6)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            )),
            child: currentBeads != null
                ? SafeArea(
                    child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: BackButton(
                            onPressed: () {
                              admobBloc.add(ShowIntersAd(DateTime.now()));
                              beadsBloc.add(SaveBeads(
                                beads: currentBeads!,
                              ));
                              GoRouter.of(context).pop();
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TopButton(
                              title: "Yeni Zikir Bul",
                              onTap: () async {
                                debugPrint(
                                    "Kaydedilecek" + currentBeads!.toString());
                                //  admobBloc.add(ShowIntersAd(DateTime.now()));
                                beadsBloc.add(SaveBeads(
                                  beads: currentBeads!,
                                ));
                                Beads? selectedBeads = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NewBeadsPage()));

                                if (selectedBeads != null) {
                                  beadsBloc.add(GetSelectedBeadsFromHive(
                                      selectedBeads: selectedBeads));
                                }
                              }),
                          TopButton(
                              title: "Eski Zikirlerin",
                              onTap: () async {
                                //    admobBloc.add(ShowIntersAd(DateTime.now()));
                                debugPrint(
                                    "Kaydedilecek" + currentBeads!.toString());
                                beadsBloc.add(SaveBeads(
                                  beads: currentBeads!,
                                ));
                                Beads? selectedBeads = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const OldsBeadsPage()));

                                if (selectedBeads != null) {
                                  beadsBloc.add(GetSelectedBeadsFromHive(
                                      selectedBeads: selectedBeads));
                                }
                              })
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: sizeHelper.height! * 0.15,
                        color: Colors.grey.withOpacity(0.6),
                        child: Center(
                          child: SizedBox(
                            width: sizeHelper.width! * 0.9,
                            child: AutoSizeText(
                              currentBeads!.bead!,
                              textAlign: TextAlign.center,
                              style: themeHelper.titleTextStyleDark.copyWith(
                                  fontSize: sizeHelper.height! * 0.04),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Container(
                        height: sizeHelper.height! * 0.1,
                        color: Colors.grey.withOpacity(0.6),
                        child: Center(
                          child: SizedBox(
                            width: sizeHelper.width! * 0.9,
                            child: AutoSizeText(
                              "Anlamı:\n" + currentBeads!.meaning!,
                              textAlign: TextAlign.center,
                              style: themeHelper.subtitleTextStyleDark.copyWith(
                                  fontSize: sizeHelper.height! * 0.02),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeHelper.height! * 0.15,
                        child: Center(
                          child: SizedBox(
                            width: sizeHelper.width! * 0.9,
                            child: AutoSizeText(
                              currentBeads!.beadedCount.toString(),
                              textAlign: TextAlign.center,
                              style: themeHelper.titleTextStyleDark
                                  .copyWith(fontSize: sizeHelper.height! * 0.1),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentBeads!.beadedCount = 0;
                          });
                        },
                        child: SizedBox(
                          height: sizeHelper.height! * 0.03,
                          child: Center(
                            child: SizedBox(
                              width: sizeHelper.width! * 0.9,
                              child: AutoSizeText(
                                "Sıfırla",
                                textAlign: TextAlign.center,
                                style: themeHelper.titleTextStyleDark.copyWith(
                                    fontSize: sizeHelper.height! * 0.1,
                                    color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentBeads!.beadedCount += 1;
                          });
                        },
                        child: Container(
                          height: sizeHelper.height! * 0.15,
                          width: sizeHelper.height! * 0.15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeHelper.onBackgroundDark,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 20,
                                  offset: const Offset(5, 10)),
                            ],
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: AutoSizeText(
                                "Bas",
                                textAlign: TextAlign.center,
                                style: themeHelper.subtitleTextStyleLight
                                    .copyWith(
                                        fontSize: sizeHelper.height! * 0.1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
