import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_id_cubit/user_cart_id_cubit.dart';
import 'package:unicorn_cafe/src/features/product_description/product_like_cubit/product_like_cubit.dart';
import 'package:unicorn_cafe/src/model/like_model.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';
import 'package:unicorn_cafe/src/widget/product_tile.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 3.w),
      child: BlocBuilder<ProductLikeCubit, List<LikeModel>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImage.emptyFavorite),
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
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 50.w,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 3.w,
                childAspectRatio: 0.65,
              ),
              itemCount: state.length,
              itemBuilder: (context, index) {
                LikeModel like = state[index];
                return FutureBuilder<ProductModel>(
                  future:
                      context.read<FirebaseCloudService>().getProduct(like.pid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      ProductModel productModel = snapshot.data!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.productDescriptionScreen,
                            arguments: productModel,
                          );
                        },
                        child: Stack(
                          children: [
                            BlocBuilder<UserCartIdCubit, UserCartIdState>(
                              builder: (context, state) {
                                bool contain =
                                    state.pid.contains(productModel.pid);
                                return ProductTile(
                                  product: productModel,
                                  onPressed: () {
                                    if (contain) {
                                      String cid =
                                          state.getCid(productModel.pid);
                                      context
                                          .read<UserCartCubit>()
                                          .removeCartProduct(cid);
                                    } else {
                                      context
                                          .read<UserCartCubit>()
                                          .addCartItem(productModel);
                                    }
                                  },
                                  icon: contain
                                      ? Icons.shopping_bag_outlined
                                      : Icons.add,
                                );
                              },
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  context.read<ProductLikeCubit>().removeLikes(
                                        state
                                            .where(
                                              (e) => productModel.pid == e.pid,
                                            )
                                            .toList()
                                            .first
                                            .lid,
                                      );
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
