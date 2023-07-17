import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginView();
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Sign In',
              style: TextStyle(
                color: AppColor.kE8B35A,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 45),
            const Text(
              'Welcome Back,',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColor.kE8B35A,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Sign in to continue',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColor.kE8B35A,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const _EmailField(),
            const SizedBox(height: 30),
            const _PasswordField(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  style: const ButtonStyle(),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColor.kE8B35A,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'Sign in',
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoute.homeScreen);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: AppColor.white),
      decoration: const InputDecoration(
        hintText: 'Enter Email',
        hintStyle: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        //labelText: 'Email',
        labelStyle: TextStyle(color: AppColor.white),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AppColor.white)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: AppColor.white),
      decoration: const InputDecoration(
        hintText: 'Enter Password',
        hintStyle: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        //labelText: 'Password',
        labelStyle: TextStyle(color: AppColor.white),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: AppColor.white)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
