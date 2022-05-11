import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key}) : super(key: key);

  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// We made this initiliazation to make sure that init state is over
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ThemeHelper(fetchedContext: context);
      SizeHelper(fetchedContext: context);
      setState(() {
        isInit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInit ? Container() : const SizedBox();
  }
}
