import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/model/cart_model.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/cart_tile.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCartCubit, List<CartModel>>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              state.isEmpty ? AppColor.white : AppColor.scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Cart',
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
          body: const CartView(),
        );
      },
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCartCubit, List<CartModel>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.emptyCart),
              const GapH(3),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.productScreen);
                },
                child: const Text(
                  'Product Explore',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          );
        }
        double totalPrice = state.fold<double>(0.0, (previousValue, element) {
          return previousValue += element.price * element.quantity;
        });
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      CartModel cart = state[index];
                      return CartTile(
                        cart: cart,
                        incrementButton: () {
                          context
                              .read<UserCartCubit>()
                              .addQuantity(cart.cid, cart.quantity + 1);
                        },
                        decrementButton: () {
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
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.shadowColor,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        totalPrice.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 20,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppButton(
                        borderRadius: BorderRadius.circular(10),
                        text: 'Process to Buy',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.addressScreen,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
