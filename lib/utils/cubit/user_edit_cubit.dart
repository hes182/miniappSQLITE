import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minigojec/db/db_repo.dart';
import 'package:minigojec/model/dao/user.dart';

part 'user_edit_state.dart';


class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit() : super(EditUserInitial());

  DBrepo _dbRepo = DBrepo();

  Future saveEditUser(String user, String noiden, String pass, String pathFile) async {
    emit(EditUserLoading());

    try {
      User newUser = User(
        userName: user.toUpperCase(),
        userIdent: noiden.toUpperCase(),
        userPass: pass,
        pathFile: pathFile,
      );
      await _dbRepo.insertDataUser(newUser);
      emit(EditUserSuccess("Berhasil Disimpan."));
    } catch(e) {
      emit(EditUserFailed("Gagal Tersimpan."));
    }
  }
  
}