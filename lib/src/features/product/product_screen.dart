import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_id_cubit/user_cart_id_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/product_cubit/product_cubit.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/product_tile.dart';

import '../../model/product_model.dart';

class ProductScreen extends StatelessWidget {
  final List<ProductModel>? products;
  const ProductScreen({
    Key? key,
    this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(context.read<FirebaseCloudService>())
        ..getAllProduct(null),
      child: _ProductView(products),
    );
  }
}

class _ProductView extends StatelessWidget {
  final List<ProductModel>? products;
  const _ProductView(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: AppColor.primaryColor,
            size: 30,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          products == null ? 'Popular' : 'Products',
          style: const TextStyle(color: AppColor.primaryColor, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: products == null
          ? BlocBuilder<ProductCubit, List<ProductModel>>(
              builder: (context, state) {
                return seeProducts(state);
              },
            )
          : seeProducts(products!),
    );
  }

  NotificationListener<OverscrollIndicatorNotification> seeProducts(
    List<ProductModel> state,
  ) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50.w,
          childAspectRatio: 0.65,
        ),
        itemCount: state.length,
        itemBuilder: (context, index) {
          ProductModel product = state[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.productDescriptionScreen,
                arguments: product,
              );
            },
            child: BlocBuilder<UserCartIdCubit, UserCartIdState>(
              builder: (context, state) {
                bool contain = state.pid.contains(product.pid);
                return ProductTile(
                  product: product,
                  onPressed: () {
                    if (contain) {
                      String cid = state.getCid(product.pid);
                      context.read<UserCartCubit>().removeCartProduct(cid);
                    } else {
                      context.read<UserCartCubit>().addCartItem(product);
                    }
                  },
                  icon: contain ? Icons.shopping_bag_outlined : Icons.add,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
