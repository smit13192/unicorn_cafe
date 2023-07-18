import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/features/auth/register/bloc/register_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';

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
    return const Scaffold();
  }
}
