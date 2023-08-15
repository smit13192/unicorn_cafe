import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/home/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/features/product_description/product_like_cubit/product_like_cubit.dart';
import 'package:unicorn_cafe/src/model/like_model.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/product_tile.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 3.w),
      child: BlocBuilder<ProductLikeCubit, List<LikeModel>>(
        builder: (context, state) {
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
                            ProductTile(
                              product: productModel,
                              onPressed: () {
                                context
                                    .read<UserCartCubit>()
                                    .addCartItem(productModel);
                                    Fluttertoast.showToast(msg: 'Add Product');
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
