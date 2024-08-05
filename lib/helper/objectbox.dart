import 'package:gypsy/model/user.dart';
import 'package:gypsy/objectbox.g.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

@JsonSerializable()
class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;

// ObjectBoxInstance(Store store)

// Creating a constructor
  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
  }

// ----------- Initialization ObjectBox --------------------------------

  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/dashBoardScreen()',
    );
    return ObjectBoxInstance(store);
  }

// ----------- User Query ----------------

  int addUser(User user) {
    return _user.put(user);
  }

  List<User> getAllUser() {
    return _user.getAll();
  }

// ---- Login User ----------------
  User? loginUser(String email, String password) {
    final userData = _user
        .query(User_.email.equals(email) & User_.password.equals(password))
        .build()
        .findFirst();

    return userData;
  }
}
