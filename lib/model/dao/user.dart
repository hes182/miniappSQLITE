import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  int? id;
  String? userName;
  String? userIdent;
  String? userPass;
  String? pathFile;

  User({this.id,this.userName, this.userIdent, this.userPass, this.pathFile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userIdent = json['userIdent'];
    userPass = json['userPass'];
    pathFile = json['userFoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['userIdent'] = userIdent;
    data['userPass'] = userPass;
    data['userFoto'] = pathFile;
    return data;
  }

  @override
  List<Object?> get props => [id,userName, userIdent, userPass, this.pathFile];

}