import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  final List<IconData> icon = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.bagShopping,
    FontAwesomeIcons.solidUser,
  ];

  AppBottomNavigationBar({
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          icon.length,
          (index) => GestureDetector(
            onTap: () {
              onChanged(index);
            },
            child: Container(
              height: double.infinity,
              width: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColor.primaryColor
                    : AppColor.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: FaIcon(
                icon[index],
                size: selectedIndex == index ? 20 : 25,
                color: selectedIndex == index
                    ? AppColor.white
                    : AppColor.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
