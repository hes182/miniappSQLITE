import 'package:flutter/material.dart';

import '../reslayout/pallete.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) {
    showDialog<void>(context: context,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(key: key,));
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(12.0),
          child: const CircularProgressIndicator(
            strokeWidth: 3.0,
            color: secondaryColorlight,
          ),
        ),
      ),
    );
  }
}
