import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minigojec/utils/cubit/sendbarangcubit/sendbarang_cubit.dart';
import 'package:minigojec/view/beranda.dart';
import 'package:minigojec/view/kirimbarang.dart';
import 'package:minigojec/view/loadinView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../reslayout/pallete.dart';
import 'customeAlertDialogView.dart';

enum FotoKategori { FotoBarang }

class SendBarangPage extends StatefulWidget {
  static const String routeName = "/sendbarang";

  @override
  _SendBarangPageState createState() => _SendBarangPageState();
}

class _SendBarangPageState extends State<SendBarangPage> {

  File? _imageBarang;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool _processingImageBarang = false;

  TextEditingController _namebarang = TextEditingController();
  TextEditingController _latA = TextEditingController();
  TextEditingController _longA = TextEditingController();
  TextEditingController _latB = TextEditingController();
  TextEditingController _longB = TextEditingController();
  TextEditingController _jarak = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namebarang.dispose();
    _latA.dispose();
    _longA.dispose();
    _latB.dispose();
    _longB.dispose();
    _jarak.dispose();
  }

  Future openCamera(FotoKategori fotoKategori) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxWidth: 480, maxHeight: 600, imageQuality: 100);

    if (pickedFile != null) {
      setState(() {
        if (fotoKategori == FotoKategori.FotoBarang) {
          _processingImageBarang = !_processingImageBarang;
        }
      });
    }

    if (fotoKategori == FotoKategori.FotoBarang) {
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
   
    return BlocProvider<SendBarangCubit>(
      create: (context) => SendBarangCubit(),
      child: BlocConsumer<SendBarangCubit, SendBarangState>(
        listener: (context, state) {
          if (state is SendBarangLoading) {
            LoadingDialog.show(context);
          } else if (state is SendBarangSuccess) {
            LoadingDialog.hide(context);
            Alert(
                context: context,
                style: AlertStyle(
                  isCloseButton: false,
                  isOverlayTapDismiss: false,
                  overlayColor: Colors.black54,
                  alertBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  buttonAreaPadding: EdgeInsets.all(10),
                ),
                title: state.message,
                buttons: [
                  DialogButton(
                    child: Text(
                      "Tutup",
                      style: TextStyle(color: Colors.white),
                    ),
                    margin: EdgeInsets.only(top: 20),
                    onPressed: () {
                    //  Navigator.of(context).pushNamedAndRemoveUntil(KirimBarangPage.routeName, (route) => false);
                    Navigator.of(context)..pop()..pop();
                    },
                    height: 45.0,
                    radius: BorderRadius.circular(5),
                  ),
                ]).show();
          } else {
            LoadingDialog.hide(context);
            CustomeAlertDialog(title: "Simpan Data Gagal", subtitle: "Data Gagal Disimpan",);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Data Barang"),
              centerTitle: true,
            ),
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Nama Barang",),
                      TextFormField(
                        controller: _namebarang,
                        keyboardType: TextInputType.text,
                        maxLength: 200,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Wajib Diisi.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Nama Barang",
                          counterText: "",
                          fillColor: scaffoldColor,
                          prefixIcon: Icon(Icons.dock)
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Lokasi Driver"),
                      SizedBox(height: 3.0,),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Latitude'),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  TextFormField(
                                    controller: _latA,
                                    keyboardType: TextInputType.number,
                                    maxLength: 30,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* Wajib Diisi.";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Latitude",
                                      counterText: "",
                                      fillColor: scaffoldColor,
                                      prefixIcon: Icon(Icons.map_sharp)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('LongLitude'),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  TextFormField(
                                    controller: _longA,
                                    keyboardType: TextInputType.number,
                                    maxLength: 30,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* Wajib Diisi.";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "LongLitude",
                                      counterText: "",
                                      fillColor: scaffoldColor,
                                      prefixIcon: Icon(Icons.map_sharp)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Lokasi Tujuan"),
                      SizedBox(height: 3.0,),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Latitude'),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  TextFormField(
                                    controller: _latB,
                                    keyboardType: TextInputType.number,
                                    maxLength: 30,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* Wajib Diisi.";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Latitude",
                                      counterText: "",
                                      fillColor: scaffoldColor,
                                      prefixIcon: Icon(Icons.map_sharp)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('LongLitude'),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  TextFormField(
                                    controller: _longB,
                                    keyboardType: TextInputType.number,
                                    maxLength: 30,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "* Wajib Diisi.";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "LongLitude",
                                      counterText: "",
                                      fillColor: scaffoldColor,
                                      prefixIcon: Icon(Icons.map_sharp)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Jarak Kirim Dalam KM"),
                      TextFormField(
                        controller: _jarak,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Wajib Diisi.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Jarak Kirim",
                          counterText: "",
                          fillColor: scaffoldColor,
                          prefixIcon: Icon(Icons.numbers)
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
                                child: Text("Foto Barang", style: Theme.of(context).textTheme.headlineSmall,),
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
                                              openCamera(FotoKategori.FotoBarang);
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
                          if (_imageBarang != null) {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<SendBarangCubit>(context)..saveSendBarang(_namebarang.text, _latA.text, _longA.text, _latB.text, _longB.text, _jarak.text, _imageBarang.toString());
                            }
                          } else {
                            CustomeAlertDialog(title: "Foto Barang", subtitle: "Foto Tidak Boleh Kosong.",);
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
              )
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