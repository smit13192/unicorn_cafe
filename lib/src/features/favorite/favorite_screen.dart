import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/features/home/page/favorite_page.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoriteView();
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(
            color: AppColor.primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.primaryColor,
          ),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
      ),
      body: const FavoritePage(),
    );
  }
}
