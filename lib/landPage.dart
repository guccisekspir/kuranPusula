import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/pages/homePage/homePage.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key}) : super(key: key);

  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  bool isInit = false;

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 10)
      ..animationDuration = const Duration(milliseconds: 10)
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid
      ..animationStyle = EasyLoadingAnimationStyle.scale
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorSize = 45.0
      ..radius = 20.0
      ..progressColor = ThemeHelper().primaryColor
      ..backgroundColor = ThemeHelper().backgroundColor
      ..indicatorColor = ThemeHelper().primaryColor
      ..textColor = Colors.pinkAccent
      ..maskColor = Colors.black.withOpacity(0.7)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// We made this initiliazation to make sure that init state is over
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ThemeHelper(fetchedContext: context);
      SizeHelper(fetchedContext: context);
      configLoading();
      setState(() {
        isInit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInit ? Scaffold(body: HomePage()) : const SizedBox();
  }
}
