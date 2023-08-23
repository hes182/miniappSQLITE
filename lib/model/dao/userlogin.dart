// ignore: must_be_immutable
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserLogin extends Equatable {
  int? id;
  String? userName;
  

  UserLogin({this.id,this.userName});

  UserLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['usLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['usLogin'] = userName;
    return data;
  }

  @override
  List<Object?> get props => [id,userName];

}