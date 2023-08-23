import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minigojec/db/db_repo.dart';
import 'package:minigojec/model/dao/mdl_sendbarang.dart';
import 'package:minigojec/view/tambahkirimbarang.dart';


import '../reslayout/pallete.dart';

class KirimBarangPage extends StatefulWidget {
  static const String routeName = "/kirimbarang";

  @override
  _KirimBarangPageState createState() => _KirimBarangPageState();
}

class _KirimBarangPageState extends State<KirimBarangPage> {

  DBrepo _dBrepo = DBrepo();
  bool cekData = false;
  MdlSendBarang? _databarang = MdlSendBarang();

  checkData() async {
    final cek = await _dBrepo.cekDataBarangSend();
    setState(() {
      cekData = cek;
    });
  }

  getData() async {
    MdlSendBarang? data = await _dBrepo.userDataGetSendBarang();
    setState(() {
      _databarang = data;
    });
  }

  @override
  void initState() {
    super.initState();
    checkData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: const Text("Kirim Barang"),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          children: [
            SizedBox(height: 8.0,),
            Text("Riwayat Kirim Barang",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            if (cekData)
            _viewCard(_databarang),
          ],
        ),
      ),
    ),
    floatingActionButton: _floatingActionButton(),
   );
  }

FloatingActionButton _floatingActionButton() {
  return FloatingActionButton.extended(
    onPressed: () {
      Navigator.pushNamed(context, SendBarangPage.routeName);
    },
    label: const Text("Tambah"),
    icon: const Icon(Icons.add),
  );
}

Card _viewCard(MdlSendBarang? databarang) {
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        Divider(
          color: primaryColor,
          thickness: .5,
          height: 0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tanggal KIrim"),
                  Text(DateFormat.yMd().add_jm().format(DateTime.parse(databarang!.tanggal.toString()))),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nama Barang"),
                  Text("${databarang.barangName.toString().toUpperCase()}"),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Koordinat Driver"),
                  Text("-${databarang.longA},${databarang.latA}"),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Koordinat Tujuan"),
                  Text("-${databarang.longB},${databarang.latB}"),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}

