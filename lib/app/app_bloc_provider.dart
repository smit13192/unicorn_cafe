import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/features/product_description/product_like_cubit/product_like_cubit.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  const AppBlocProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductLikeCubit(
        firebaseAuthService: context.read<FirebaseAuthService>(),
        firebaseCloudService: context.read<FirebaseCloudService>(),
      ),
      child: child,
    );
  }
}
