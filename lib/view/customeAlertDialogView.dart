

import 'package:flutter/material.dart';

class CustomeAlertDialog extends StatelessWidget {

  static void show(BuildContext context, String title, String subtitle, {Key? key}) {
    showDialog<void>(context: context, 
    builder: (_) => CustomeAlertDialog(
      key: key,
      title: title,
      subtitle: subtitle,
    ));
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  final String? title;
  final String? subtitle;
  const CustomeAlertDialog({Key? key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('$subtitle'),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed:() {Navigator.of(context).pop();}, 
        child: const Text('Tutup'))
      ],
    );
  }

}