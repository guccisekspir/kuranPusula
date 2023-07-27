import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kuranpusula/blocs/beadsBloc/bloc/beads_bloc.dart';
import 'package:kuranpusula/helpers/sizeHelper.dart';
import 'package:kuranpusula/helpers/themeHelper.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';
import 'package:kuranpusula/pages/beadsPage/subPages/oldBeadsPage/widgets/oldBeadsWidget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OldsBeadsPage extends StatefulWidget {
  const OldsBeadsPage({Key? key}) : super(key: key);

  @override
  State<OldsBeadsPage> createState() => _OldsBeadsPageState();
}

class _OldsBeadsPageState extends State<OldsBeadsPage> {
  ThemeHelper themeHelper = ThemeHelper();
  SizeHelper sizeHelper = SizeHelper();
  BeadsBloc beadsBloc = getIt<BeadsBloc>();
  List<Beads>? userBeads;
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
          setState(() {
            userBeads = state.beads;
          });
        } else if (state is BeadsLoadError) {
          EasyLoading.dismiss();
          showTopSnackBar(Overlay.of(context),
              const CustomSnackBar.error(message: "Bir hata oluştu"));
        }
      },
      child: Container(
        height: sizeHelper.height,
        width: sizeHelper.width,
        color: themeHelper.backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const Align(alignment: Alignment.centerLeft, child: BackButton()),
              Text(
                "Önceki tespihlerin",
                style: themeHelper.titleTextStyleDark
                    .copyWith(fontSize: sizeHelper.height! * 0.03),
              ),
              userBeads != null
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: userBeads!.length,
                          itemBuilder: ((context, index) {
                            return OldBeadWidget(
                                currentBeads: userBeads![index]);
                          })),
                    )
                  : Text(
                      "Herhangi bir tespihin bulunmuyor!",
                      style: themeHelper.titleTextStyleDark
                          .copyWith(color: Colors.red),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
