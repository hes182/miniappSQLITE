import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minigojec/db/db_repo.dart';
import 'package:minigojec/model/dao/userlogin.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  DBrepo dbRepo = DBrepo();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmit) {
      yield LoginLoading();

      try {
        bool cekUser = await dbRepo.cekUserData();
        if (cekUser) {
         final user = await dbRepo.userDataGet();
         if (user?.userName == event.username && user?.userPass == event.password) {
            final newuser = UserLogin(userName: user?.userName);
            await dbRepo.insertDataUserLog(newuser);
            yield LoginSuccess("Loggin");
         } else {
          yield LoginFailed("Gagal Login");
         }
        } else {
          if ((event.username == "DRIVER 1") && (event.password == "1234")) {
            final newuser = UserLogin(userName: event.username);
             await dbRepo.insertDataUserLog(newuser);
            yield LoginSuccess("Loggin");
          }else {
            yield LoginFailed("Gagal Login");
          }
        }
      } catch (e) {
        yield LoginFailed(e.toString());
      }
    }

    if (event is LogoutSubmit) {
      yield LoginLoading();
      await Future.delayed(Duration(milliseconds: 500));
      await dbRepo.deleteDataUser();
      yield LogoutSuccess();
    }

  }

}