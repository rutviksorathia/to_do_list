import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/ui/views/login/login_view.dart';
import 'package:to_do_list/ui/views/to_do_list/to_do_list_view.dart';

class StartupViewModel extends BaseViewModel {
  void checkAuthentication() async {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      await Future.delayed(const Duration(seconds: 2));
      Get.to(() => const ToDoListView());
    } else {
      await Future.delayed(const Duration(seconds: 2));
      Get.to(() => const LoginView());
    }
  }
}
