import 'package:minigojec/db/dao/userDao.dart';
import 'package:minigojec/model/dao/mdl_sendbarang.dart';

import '../model/dao/user.dart';
import '../model/dao/userlogin.dart';

class DBrepo {
  final userDao = UserDao();

  // User Action
  Future<bool> cekUserData() async {
    bool result = await userDao.checkUser();
    return result;
  }

  Future<void> insertDataUser(User user) async {
    await userDao.insertUser(user);
  }

  Future<void> deleteDataUser() async {
    await userDao.deleteUser();
  }

  Future<User?> userDataGet() async {
    return await userDao.getUser();
  }

  // Data LogUse
  Future<bool> cekLogUse() async {
    bool result = await userDao.checkUserLog();
    return result;
  }

  Future<void> insertDataUserLog(UserLogin user) async {
    await userDao.insertUserLogin(user);
  }

  Future<void> deleteDataUserLog() async {
    await userDao.deleteUserLog();
  }

   Future<bool> cekDataBarangSend() async {
    bool result = await userDao.checkDataBarang();
    return result;
  }

  Future<void> insertDataBarangSend(MdlSendBarang barang) async {
    await userDao.insertDataBarang(barang);
  }

  Future<void> deleteDataBarangSend() async {
    await userDao.deleteDataBarang();
  }

  Future<MdlSendBarang?> userDataGetSendBarang() async {
    return await userDao.getDataBarang();
  }


}