import 'package:equatable/equatable.dart';

class MdlSendBarang extends Equatable {
  int? id;
  String? barangName;
  String? latA;
  String? longA;
  String? latB;
  String? longB;
  String? jarak;
  String? barangFoto;
  String? tanggal;

  MdlSendBarang({this.id,this.barangName, this.latA, this.longA, this.latB, this.longB, this.jarak, this.barangFoto, this.tanggal});

  MdlSendBarang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barangName = json['barangName'];
    latA = json['barangLatA'];
    longA = json['barangLongA'];
    latB = json['barangLatB'];
    longB = json['barangLongB'];
    jarak = json['barangJarak'];
    barangFoto = json['barangFoto'];
    tanggal = json['barangTanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['barangName'] = barangName;
    data['barangLatA'] = latA;
    data['barangLongA'] = longA;
    data['barangLatB'] = latB;
    data['barangLongB'] = longB;
    data['barangJarak'] = jarak;
    data['barangFoto'] = barangFoto;
    data['barangTanggal'] = tanggal;
    return data;
  }

  @override
  List<Object?> get props => [id,barangName, latA, longA, latB, longB, jarak, tanggal];

}