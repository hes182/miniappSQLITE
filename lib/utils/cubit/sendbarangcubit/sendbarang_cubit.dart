import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minigojec/db/db_repo.dart';
import 'package:minigojec/model/dao/mdl_sendbarang.dart';

part 'sendbarang_state.dart';

class SendBarangCubit extends Cubit<SendBarangState> {
  SendBarangCubit() : super(SendBarangInitial());

  DBrepo dbRepo = DBrepo();

  Future saveSendBarang(String namabarang, String latA, String longA, String latB, String longB, String jarak, String pathFoto)async {
    emit(SendBarangLoading());

    try {
      MdlSendBarang newBarang = MdlSendBarang(
        barangName: namabarang,
        latA: latA,
        longA: longA,
        latB: latB,
        longB: longB,
        jarak: jarak,
        barangFoto: pathFoto,
        tanggal: DateTime.now().toString(),
      );
      print("data barang : " + newBarang.toString());
      await dbRepo.insertDataBarangSend(newBarang);
      emit(SendBarangSuccess("Berhasil Tesimpan"));
    } catch(e) {
      emit(SendBarangFailed("Gagal Tersimpan"));
    }
  }
}