import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/ui/views/to_do_list/to_do_list_view.dart';

class LoginViewModel extends BaseViewModel {
  bool isLogin;

  LoginViewModel({required this.isLogin});

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool get isLoading {
    return (busy('isLogin') || busy('isRegister'));
  }

  void toggleAuthMode() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isLogin = !isLogin;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null) {
      return 'Username is required';
    } else {
      if (value.isEmpty || value.length < 4) {
        return 'Username is too short';
      }
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return 'Email is required';
    } else {
      if (value.isEmpty || !value.contains('@')) {
        return 'Invalid email';
      }
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value == null) {
      return 'Password is required';
    } else {
      if (value.isEmpty || value.length < 7) {
        return 'Password is too short';
      }
      return null;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (value == null) {
      return 'Confirm Password is required';
    } else {
      if (value.isEmpty || value.length < 7) {
        return 'Confirm Password is too short';
      }
      return null;
    }
  }

  Future<void> handleRegisterButtonTap(String email, String password) async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Password and confirm password do not match',
          isDismissible: true,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red);
      return;
    }
    try {
      setBusyForObject('isRegister', true);
      notifyListeners();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.to(() => const ToDoListView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.',
            isDismissible: true,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.',
            isDismissible: true,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          isDismissible: true,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red);
    } finally {
      setBusyForObject('isRegister', false);
      notifyListeners();
    }
  }

  Future<void> handleLoginButtonTap(String email, String password) async {
    try {
      setBusyForObject('isLogin', true);
      notifyListeners();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.to(() => const ToDoListView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.',
            isDismissible: true,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red);
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        Get.snackbar('Error', 'Wrong password provided for that user.',
            isDismissible: true,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          isDismissible: true,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red);
    } finally {
      setBusyForObject('isLogin', false);
      notifyListeners();
    }
  }
}
