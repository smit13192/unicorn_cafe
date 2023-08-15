import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/model/cart_model.dart';
import 'package:unicorn_cafe/src/widget/cart_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class CartTile extends StatelessWidget {
  final CartModel cart;
  final Function() incrementButton;
  final Function() decrementButton;
  const CartTile({
    super.key,
    required this.cart,
    required this.incrementButton,
    required this.decrementButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 4.w, right: 4.w),
      height: 120,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 2),
            color: AppColor.shadowColor,
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              cart.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                Text(
                  cart.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const GapH(0.2),
                Text(
                  cart.subtitle,
                  maxLines: 2,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.thirdColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '₹${cart.price.toString()}',
                      style: const TextStyle(
                        fontSize: 17,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    CartButton(
                      text: '+',
                      onPressed: () {
                        context
                            .read<UserCartCubit>()
                            .addQuantity(cart.cid, cart.quantity + 1);
                      },
                    ),
                    const GapW(1),
                    CartButton(
                      text: cart.quantity.toString(),
                      color: AppColor.lightGreyColor,
                      textColor: AppColor.primaryColor,
                    ),
                    const GapW(1),
                    CartButton(
                      text: '-',
                      onPressed: () {
                        if (cart.quantity == 1) {
                          context
                              .read<UserCartCubit>()
                              .removeCartProduct(cart.cid);
                        } else {
                          context
                              .read<UserCartCubit>()
                              .removeQuantity(cart.cid, cart.quantity - 1);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 7),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
