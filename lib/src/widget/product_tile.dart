import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.product,
    required this.onPressed,
    required this.icon,
  });

  final Function() onPressed;
  final ProductModel product;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: AppColor.shadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: Image.network(
                product.image,
                width: 46.5.w,
                height: 46.5.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const GapH(0.5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const GapH(0.2),
                Text(
                  product.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.thirdColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const GapH(1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${product.price.toString()}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Material(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(18),
                      elevation: 3,
                      shadowColor: AppColor.primaryColor.withOpacity(0.50),
                      child: InkWell(
                        onTap: onPressed,
                        borderRadius: BorderRadius.circular(18),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            icon,
                            size: 15,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const GapH(1),
        ],
      ),
    );
  }
}
