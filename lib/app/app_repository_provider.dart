import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class AppRepositoryProvider extends StatelessWidget {
  final Widget child;
  const AppRepositoryProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => FirebaseAuthService()),
        RepositoryProvider(create: (context) => FirebaseCloudService()),
      ],
      child: child,
    );
  }
}
