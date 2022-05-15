import 'dart:ui';

import 'package:flutter/material.dart';

class BuzzedContainer extends StatelessWidget {
  final Widget child;
  const BuzzedContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: child,
    ));
  }
}
