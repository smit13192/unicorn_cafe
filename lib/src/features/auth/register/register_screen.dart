import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/features/auth/register/bloc/register_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        firebaseAuthService: context.read<FirebaseAuthService>(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: AppColor.kE8B35A,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Welcome,',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColor.kE8B35A,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'SignUp to start your new Journey',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColor.kE8B35A,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            const _FullNameTextField(),
            const SizedBox(height: 30),
            const _EmailTextField(),
            const SizedBox(height: 30),
            const _MobileNumberTextField(),
            const SizedBox(height: 30),
            const _PasswordTextField(),
            const SizedBox(height: 30),
            const _ConfirmPasswordTextField(),
            const SizedBox(height: 50),
            AppButton(
              text: 'Sign up',
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

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: const TextStyle(color: AppColor.white),
      decoration: const InputDecoration(
        hintText: 'Enter Full Name',
        hintStyle: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

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
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _MobileNumberTextField extends StatelessWidget {
  const _MobileNumberTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: AppColor.white),
      decoration: const InputDecoration(
        hintText: 'Enter Mobile Number',
        hintStyle: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: AppColor.white),
      decoration: const InputDecoration(
        hintText: 'Enter Password',
        hintStyle: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  const _ConfirmPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      style: const TextStyle(color: AppColor.white),
      decoration: const InputDecoration(
        hintText: 'Enter Confirm Password',
        hintStyle: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
