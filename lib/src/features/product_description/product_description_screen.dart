import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/home/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/features/product_description/product_like_cubit/product_like_cubit.dart';
import 'package:unicorn_cafe/src/model/like_model.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/app_outlined_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class ProductDescriprionScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDescriprionScreen({super.key, required this.productModel});

  @override
  State<ProductDescriprionScreen> createState() =>
      _ProductDescriprionScreenState();
}

class _ProductDescriprionScreenState extends State<ProductDescriprionScreen> {
  @override
  Widget build(BuildContext context) {
    return ProductDescriprionView(widget.productModel);
  }
}

class ProductDescriprionView extends StatelessWidget {
  final ProductModel product;
  const ProductDescriprionView(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          BlocBuilder<ProductLikeCubit, List<LikeModel>>(
            builder: (context, state) {
              return IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  if (state.map((e) => e.pid).toList().contains(product.pid)) {
                    context.read<ProductLikeCubit>().removeLikes(
                          state
                              .where((e) => product.pid == e.pid)
                              .toList()
                              .first
                              .lid,
                        );
                  } else {
                    context.read<ProductLikeCubit>().addLikes(product.pid);
                  }
                },
                icon: state.map((e) => e.pid).toList().contains(product.pid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border_outlined),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                    color: AppColor.shadowColor,
                  ),
                ],
              ),
              child: Image.network(
                product.image,
                height: 120.w,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.w),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const GapH(3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                product.type,
                                style: const TextStyle(
                                  color: AppColor.subtitleColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '₹${product.price.toString()}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const GapH(1),
                      Row(
                        children: [
                          Image.asset(AppImage.star, height: 30, width: 30),
                          const GapW(1.5),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: product.star.toString(),
                                  style: const TextStyle(
                                    color: AppColor.primaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' (${product.review.toString()})',
                                  style: const TextStyle(
                                    color: AppColor.subtitleColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const GapH(0.5),
                      const Divider(),
                      const GapH(0.5),
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const GapH(1),
                      Text(
                        product.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: AppColor.subtitleColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    text: 'Add to cart',
                    onPressed: () {
                      context.read<UserCartCubit>().addCartItem(product);
                      Fluttertoast.showToast(msg: 'Add Product');
                    },
                  ),
                ),
                const GapW(3),
                Expanded(
                  child: AppButton(
                    text: 'Buy Now',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
