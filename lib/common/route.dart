import 'package:flutter/material.dart';
import 'package:minigojec/view/beranda.dart';
import 'package:minigojec/view/edituser.dart';
import 'package:minigojec/view/loginview.dart';
import 'package:minigojec/view/tambahkirimbarang.dart';
import 'package:path/path.dart';

import '../view/kirimbarang.dart';

var routeName = <String, WidgetBuilder> {

  LoginPage.routeName: (context) => LoginPage(),
  BerandaPage.routeName: (context) => BerandaPage(),
  EditUserPage.routeName:(context) => EditUserPage(),
  KirimBarangPage.routeName: (context) => KirimBarangPage(),
  SendBarangPage.routeName: (context) => SendBarangPage(),
};