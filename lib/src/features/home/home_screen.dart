import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/string/app_string.dart';
import 'package:unicorn_cafe/src/features/home/cubit/bottom_navigation_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/cart_page.dart';
import 'package:unicorn_cafe/src/features/home/page/favorite_page.dart';
import 'package:unicorn_cafe/src/features/home/page/product_page.dart';
import 'package:unicorn_cafe/src/features/home/page/profile_page.dart';
import 'package:unicorn_cafe/src/features/product_description/product_like_bloc/product_like_bloc.dart';
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

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final List<Widget> _pages = [
    const ProductPage(),
    const FavoritePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductLikeBloc>().fetchLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppString.appName,
          style: TextStyle(color: AppColor.primaryColor, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<BottomNavigationCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: _pages,
          );
        },
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
