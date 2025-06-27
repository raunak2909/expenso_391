import 'package:expenso_391/data/local/helper/db_helper.dart';

import '../models/user_model.dart';

class UserRepository{
  DBHelper dbHelper;

  UserRepository({required this.dbHelper});

  ///events
  Future<int> registerUser({required UserModel newUser}) async{

    ///1->success
    ///2->failure(email already exists)
    ///2->failure(mobNo already exists)
    ///4->error

    if(await dbHelper.ifUserEmailExists(email: newUser.email)){
      return 2;
    } else if(await dbHelper.ifUserMobileExists(mobNo: newUser.mobNo)){
      return 3;
    } else {
      bool check = await dbHelper.registerUser(newUser: newUser);
      if(check){
        return 1;
      } else {
        return 4;
      }
    }


  }

  authenticateUser(){

  }


}