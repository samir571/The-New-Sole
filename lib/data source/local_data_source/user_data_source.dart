import 'package:gypsy/model/user.dart';
import 'package:gypsy/state/objectbox_state.dart';

import '../../helper/objectbox.dart';

class UserDataSource {
  ObjectBoxInstance objectBoxInstance = ObjectBoxState.objectBoxInstance!;

// Add User
  Future<int> addUser(User user) async {
    try {
      return objectBoxInstance.addUser(user);
    } catch (e) {
      return Future.value(0);
    }
  }
// Get user data

  Future<List<User>> getUser() async {
    try {
      return Future.value(objectBoxInstance.getAllUser());
    } catch (e) {
      throw Exception('Error getting user');
    }
  }

//  Login user
  Future<User?> loginUser(String email, String password) {
    try {
      return Future.value(objectBoxInstance.loginUser(email, password));
    } catch (e) {
      throw Exception(null);
    }
  }
}
