// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:get/instance_manager.dart';
import 'package:gypsy/screen/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
