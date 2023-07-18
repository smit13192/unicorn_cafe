import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/features/auth/login/bloc/login_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(firebaseAuthService: context.read<FirebaseAuthService>()),
      child: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  _LoginView();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.homeScreen, (route) => false);
        } else if (state.status.isFailed) {
          Fluttertoast.showToast(msg: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Sign In',
            style: TextStyle(
              color: AppColor.kE8B35A,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                const _EmailTextField(),
                const SizedBox(height: 30),
                const _PasswordTextField(),
                const SizedBox(height: 15),
                const Text(
                  'Forgot Password?',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColor.kE8B35A,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  text: 'Sign in',
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitEvent());
                    }
                  },
                )
              ],
            ),
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
    context.select((LoginBloc bloc) => bloc.state.email);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: AppColor.white),
      onChanged: (value) {
        context.read<LoginBloc>().add(EmailChangedEvent(value.trim()));
      },
      validator: (value) {
        if (!EmailValidator.validate(value!)) {
          return 'Enter valid email';
        }
        return null;
      },
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

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    context.select((LoginBloc value) => value.state.password);
    bool obscureText =
        context.select((LoginBloc value) => value.state.passwordObscureText);

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      style: const TextStyle(color: AppColor.white),
      onChanged: (value) {
        context.read<LoginBloc>().add(PasswordChangedEvent(value.trim()));
      },
      validator: (value) {
        if (value == null || value.contains(' ')) {
          return 'Enter valid password';
        } else if (value.length < 8) {
          return 'Password length must be greater than 8';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter Password',
        hintStyle: const TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            context.read<LoginBloc>().add(PasswordToggleEvent());
          },
          icon: obscureText
              ? const Icon(
                  Icons.visibility,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
