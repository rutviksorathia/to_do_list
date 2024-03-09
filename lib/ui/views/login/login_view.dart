import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_list/ui/views/login/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  final bool isLogin;

  const LoginView({
    super.key,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(isLogin: isLogin),
        builder: (context, model, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top + 38),
                      Center(
                        child: Text(
                          model.isLogin
                              ? 'Welcome to Todoist'
                              : 'Create Your Account',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          model.isLogin
                              ? 'A Simple Task Creation and Management tool helps you to manage your ay to day task,'
                              : 'Create your account now and manage your day to day task on the go using Todoist',
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (!model.isLogin) const SizedBox(height: 27),
                      model.isLogin
                          ? SvgPicture.asset(
                              'assets/images/login_illustration.svg',
                              height: 319,
                              fit: BoxFit.cover,
                            )
                          : SvgPicture.asset(
                              'assets/images/register_illustration.svg',
                              height: 177,
                              fit: BoxFit.cover,
                            ),
                      if (!model.isLogin) const SizedBox(height: 27),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.isLogin ? 'Login' : 'Register ',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (!model.isLogin)
                            TextFormField(
                              key: const ValueKey('username'),
                              decoration: const InputDecoration(
                                labelText: 'Enter Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                constraints: BoxConstraints.tightFor(
                                  height: 50,
                                ),
                              ),
                              validator: ((value) =>
                                  model.validateUsername(value)),
                              onSaved: (value) => model.username = value!,
                            ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: const ValueKey('email'),
                            decoration: const InputDecoration(
                              labelText: 'Enter Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              constraints: BoxConstraints.tightFor(
                                height: 50,
                              ),
                            ),
                            validator: (value) => model.validateEmail(value),
                            onSaved: (value) => model.email = value!,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            key: const ValueKey('password'),
                            obscureText: !model.isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Enter Password',
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              suffixIcon: model.isLogin
                                  ? GestureDetector(
                                      onTap: model.togglePasswordVisibility,
                                      child: model.isPasswordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    )
                                  : null,
                              constraints:
                                  const BoxConstraints.tightFor(height: 50),
                            ),
                            validator: (value) => model.validatePassword(value),
                            onSaved: (value) => model.password = value!,
                          ),
                          const SizedBox(height: 20),
                          if (!model.isLogin)
                            TextFormField(
                              key: const ValueKey('Confirm Password'),
                              obscureText: !model.isConfirmPasswordVisible,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: model.toggleConfirmPasswordVisibility,
                                  child: model.isConfirmPasswordVisible
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                                constraints:
                                    const BoxConstraints.tightFor(height: 50),
                              ),
                              validator: (value) =>
                                  model.validateConfirmPassword(value),
                              onSaved: (value) =>
                                  model.confirmPassword = value!,
                            ),
                          const SizedBox(height: 24),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();
                                if (isValid) {
                                  formKey.currentState!.save();
                                  if (model.isLogin) {
                                    model.handleLoginButtonTap(
                                        model.email, model.password);
                                  } else {
                                    model.handleRegisterButtonTap(
                                        model.email, model.password);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7C3AED),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    model.isLogin ? 'Login' : 'Register',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (model.isLoading)
                                    const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: model.isLogin
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account ?",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: model.toggleAuthMode,
                                        child: const Text(
                                          'Create Account',
                                          style: TextStyle(
                                            color: Color(0xFF7C3AED),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account ?',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      GestureDetector(
                                        onTap: model.toggleAuthMode,
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Color(0xFF7C3AED),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
