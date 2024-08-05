import 'package:gypsy/data%20source/local_data_source/user_data_source.dart';
import 'package:gypsy/model/user.dart';

abstract class UserRepositoryOB {
  Future<List<User>> getUser();
  Future<int> addUser(User user);

  // Login
  Future<User?> loginUser(String email, String password);
}

class UserRepositoryImplementation extends UserRepositoryOB {
  @override
  Future<int> addUser(User user) {
    return UserDataSource().addUser(user);
  }

  @override
  Future<List<User>> getUser() {
    return UserDataSource().getUser();
  }

  @override
  Future<User?> loginUser(String email, String password) {
    return UserDataSource().loginUser(email, password);
  }
}
