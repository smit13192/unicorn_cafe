// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const GapH(2),
              Row(
                children: [
                  const GapW(5),
                  CircleAvatar(
                    radius: 45,
                    child: Text(
                      context
                          .read<FirebaseAuthService>()
                          .email[0]
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  const GapW(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello,',
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        context.read<FirebaseAuthService>().email,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const GapH(3),
              _ProfileTile(
                text: 'Orders',
                onTap: () {},
              ),
              _ProfileTile(
                text: 'Carts',
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.cartScreen);
                },
              ),
              _ProfileTile(
                text: 'Favorite',
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.favoriteScreen);
                },
              ),
              _ProfileTile(
                text: 'Customer Care',
                onTap: () {},
              ),
              _ProfileTile(
                text: 'My Rewards',
                onTap: () {},
              ),
              _ProfileTile(
                text: 'Saved Card',
                onTap: () {},
              ),
              _ProfileTile(
                text: 'Address',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppButton(
        margin: const EdgeInsets.all(20.0),
        text: 'Log Out',
        onPressed: () async {
          context.read<FirebaseAuthService>().logOut();
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.googlelogin,
            (route) => false,
          );
        },
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String text;
  final Function() onTap;
  const _ProfileTile({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.3.h),
      child: Material(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 3,
        shadowColor: AppColor.shadowColor,
        child: InkWell(
          splashColor: AppColor.primaryColor.withOpacity(0.20),
          highlightColor: AppColor.primaryColor.withOpacity(0),
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const GapW(5),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.primaryColor,
                ),
                const GapW(5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
