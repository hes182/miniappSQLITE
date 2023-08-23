import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minigojec/db/db_repo.dart';
import 'package:minigojec/reslayout/pallete.dart';
import 'package:minigojec/utils/bloc/login/login_bloc.dart';
import 'package:minigojec/view/edituser.dart';
import 'package:minigojec/view/loadinView.dart';
import 'package:minigojec/view/loginview.dart';

import '../model/dao/user.dart';
import 'kirimbarang.dart';


class BerandaPage extends StatefulWidget {
  static String routeName = "/beranda";

  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>{
  DBrepo? _dbRepo;
  bool _isUser = false;
  User? userData = User();

  @override
  void initState() {
    super.initState();
    _dbRepo = DBrepo();
    checkUser();
    getUser();
  }

  Future getUser() async {
    User? userList = await _dbRepo!.userDataGet();
    setState(() {
      userData = userList;
    });
  }

  Future checkUser() async {
    bool isUserChek = await _dbRepo!.cekUserData();
    setState(() {
      _isUser = isUserChek;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
          create: (context) => LoginBloc(),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                LoadingDialog.show(context);
              }else if (state is LogoutSuccess) {
                LoadingDialog.hide(context);
                Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [primaryColor, Color(0xFF7AA2FF)],
                        ),
                      ),
                      child: _isUser ? Card(
                        elevation: 10,
                        color: textColorlight,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5 - (20.0 * 1.9),
                          child:Image.file(
                          File(userData!.pathFile.toString()),
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          )
                          ),
                        )
                      : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25.0,
                        child:  Text("C",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: primaryColor),),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: textColorlight, width: 1),
                        ),
                        color: Color.fromARGB(255, 144, 224, 249),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text("Nama Driver",
                              style: Theme.of(context).textTheme.titleSmall,),
                            ),
                            Expanded(
                              child: Text(
                                _isUser ? userData!.userName.toString().trim().toUpperCase()  : 'DRIVER 1',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: textColorlight, width: 1),
                        ),
                        color: Color.fromARGB(255, 144, 224, 249),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text("No.Identitas",
                              style: Theme.of(context).textTheme.titleSmall,),
                            ),
                            Expanded(
                              child: Text(
                                _isUser ? userData!.userIdent.toString() : '',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: textColorlight, width: 1),
                        ),
                        color: Color.fromARGB(255, 144, 224, 249),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text("Password",
                              style: Theme.of(context).textTheme.titleSmall,),
                            ),
                            Expanded(
                              child: Text(
                                _isUser ? userData!.userPass.toString() : '1234',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, EditUserPage.routeName);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: textColorlight, width: 1),
                          ),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: Text(
                            "Edit Akun",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, KirimBarangPage.routeName);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: textColorlight, width: 1),
                          ),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: Text(
                            "Kirim Barang",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context)..add(LogoutSubmit());
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: textColorlight, width: 1),
                          ),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: Text(
                            "Keluar",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          trailing: const Icon(
                            Icons.logout,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ),
    );
  }

}