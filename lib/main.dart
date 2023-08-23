
import 'package:flutter/material.dart';
import 'package:minigojec/db/db_repo.dart';
import 'package:minigojec/view/beranda.dart';
import 'package:minigojec/view/loginview.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await [
    Permission.storage,
    Permission.location,
    Permission.camera,
  ].request();

  final dbRepo = DBrepo();
   bool _chekUser = false;

  _chekUser = await dbRepo.cekLogUse();

  runApp(MyApp(userChekin: _chekUser,));
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();
  final bool? userChekin;

  const MyApp({Key? key, this.userChekin}) : super(key: key);  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: !userChekin! ? LoginPage() : BerandaPage(),
      navigatorKey: MyApp.navigatorKey,
      routes: routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool userChek = false;

  void chekUser() async  {
    DBrepo dBrepo = DBrepo();
    userChek = await dBrepo.cekUserData();
  }

  @override
  void initState() {
    super.initState();
    chekUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: userChek ? Container() : LoginPage() ,
    );
  }
}
