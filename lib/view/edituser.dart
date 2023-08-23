import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minigojec/reslayout/pallete.dart';
import 'package:minigojec/utils/cubit/user_edit_cubit.dart';
import 'package:minigojec/view/beranda.dart';
import 'package:minigojec/view/customeAlertDialogView.dart';
import 'package:minigojec/view/loadinView.dart';
import 'package:permission_handler/permission_handler.dart';

enum FotoKategori { FotoUser }

class EditUserPage extends StatefulWidget {
  static String routeName = '/editakun';
  const EditUserPage({Key? key}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _user = TextEditingController();
  final TextEditingController _noidn = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _passvisible = false;

  File? _imageBarang;
  final picker = ImagePicker();
  bool _processingImageBarang = false;

  @override
  void dispose() {
    super.dispose();
    _user.dispose();
    _noidn.dispose();
    _pass.dispose();
  }

Future openCamera(FotoKategori fotoKategori) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxWidth: 480, maxHeight: 600, imageQuality: 100);

    if (pickedFile != null) {
      setState(() {
        if (fotoKategori == FotoKategori.FotoUser) {
          _processingImageBarang = !_processingImageBarang;
        }
      });
    }

    if (fotoKategori == FotoKategori.FotoUser) {
      await Future.delayed(Duration(milliseconds: 500));
      try {
       setState(() {
        if (pickedFile != null) {
          _imageBarang = File(pickedFile.path);
          _processingImageBarang = !_processingImageBarang;
        } else {
          _imageBarang = null;
          _processingImageBarang = _processingImageBarang;
        }
        
       });
      } on Exception catch(e) {
        setState(() {
          _imageBarang = null;
          _processingImageBarang = !_processingImageBarang;
        });
      }
    }
  }  

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<EditUserCubit>(
        create: (context) => EditUserCubit(),
        child: BlocConsumer<EditUserCubit, EditUserState>(
          listener: (context, state) {
            if (state is EditUserLoading) {
              LoadingDialog.show(context);
            } else if (state is EditUserFailed) {
              LoadingDialog.hide(context);
              CustomeAlertDialog(title: "Ubah Data User", subtitle: "Gagal Disimpan.",);
            } else if(state is EditUserSuccess) {
              LoadingDialog.show(context);
              CustomeAlertDialog(title: "Ubah Data User", subtitle: "Data Berhasil Disimpan",);
              Navigator.pushNamedAndRemoveUntil(context, BerandaPage.routeName, (route) => false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: Text( "Edit Data User"),
              centerTitle: true,),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Nama User"),
                        TextFormField(
                          controller: _user,
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Wajib Diisi.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Nama User",
                            counterText: "",
                            fillColor: scaffoldColor,
                            prefixIcon: Icon(Icons.people)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Nomor Identitas"),
                        TextFormField(
                          controller: _noidn,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Wajib Diisi.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Nomor Identitas",
                            counterText: "",
                            fillColor: scaffoldColor,
                            prefixIcon: Icon(Icons.numbers)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Password"),
                        TextFormField(
                          controller: _pass,
                          keyboardType: TextInputType.text,
                          obscureText: _passvisible,
                          maxLength: 50,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Wajib Diisi.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            counterText: "",
                            fillColor: scaffoldColor,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _passvisible = !_passvisible;
                                });
                              },
                              icon: Icon(_passvisible ? Icons.visibility : Icons.visibility_off),
                            )
                          ),
                        ),
                        SizedBox(height: 15,),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text("Foto User", style: Theme.of(context).textTheme.headlineSmall,),
                              ),
                            ),
                            SizedBox(height: 3.0,),
                            Wrap(
                              spacing: 20.0 * 0.2,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            Map<Permission, PermissionStatus> statuses = await [
                                              Permission.storage,
                                              Permission.location,
                                              Permission.camera,
                                            ].request();

                                            if (statuses[Permission.location] == PermissionStatus.granted && statuses[Permission.storage] == PermissionStatus.granted) {
                                              openCamera(FotoKategori.FotoUser);
                                            } 
                                          },
                                          child: Card(
                                            color: textColorlight,
                                            child: Container(
                                              height: MediaQuery.of(context).size.width * 0.5,
                                              width: MediaQuery.of(context).size.width * 0.5 - (20.0 * 1.9),
                                              child: _imageBarang == null
                                              ? Center(
                                                child: Icon(Icons.camera, color: textColor,),
                                                ) : Image.file(
                                                  _imageBarang!,
                                                  fit: BoxFit.cover,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  alignment: Alignment.center,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        _processingImageBarang ? _buildProgressIndicatorFotoUpload(context) : SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: 30,),
                        TextButton(
                          onPressed: () async {
                            if (_imageBarang != null){ 
                              if (_formkey.currentState!.validate()) {
                                BlocProvider.of<EditUserCubit>(context)..saveEditUser(_user.text, _noidn.text, _pass.text, _imageBarang!.path.toString());
                              }
                            } else {
                              CustomeAlertDialog(title: "Foto Kosong", subtitle: "Foto Tidak Boleh Kosong",);
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: primaryColor,
                              minimumSize: Size(double.infinity, 10.0),
                            ),
                          child: Text("Simpan Data", style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }

Container _buildProgressIndicatorFotoUpload(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5 - (20.0 * 1.5),
      color: Colors.transparent,
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: secondaryColorlight,
          ),
          Text(
            "Mohon tunggu...",
            style: TextStyle(color: secondaryColorlight),
          ),
        ],
      ),
    );
  }

}