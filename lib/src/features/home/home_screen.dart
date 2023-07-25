import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/features/home/cubit/bottom_navigation_cubit.dart';
import 'package:unicorn_cafe/src/widget/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'UNICORN CAFE',
          style: TextStyle(color: AppColor.primaryColor, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return AppBottomNavigationBar(
            selectedIndex: state,
            onChanged: (value) {
              context.read<BottomNavigationCubit>().indexChanged(value);
            },
          );
        },
      ),
    );
  }
}
