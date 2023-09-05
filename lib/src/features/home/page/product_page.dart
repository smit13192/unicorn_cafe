import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_id_cubit/user_cart_id_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/category_index_cubit/category_index_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/category_product_cubit/category_product_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/category_type_cubit/category_type_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/product_cubit/product_cubit.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryIndexCubit(),
        ),
        BlocProvider(
          create: (context) =>
              CategoryTypeCubit(context.read<FirebaseCloudService>())
                ..getTypes(),
        ),
        BlocProvider(
          create: (context) =>
              ProductCubit(context.read<FirebaseCloudService>())
                ..getAllProduct(5),
        ),
      ],
      child: const _ProductView(),
    );
  }
}

class _ProductView extends StatelessWidget {
  const _ProductView();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GapH(1),
              const Text(
                'Good Morning',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GapH(2),
              const _SearchField(),
              const GapH(2),
              const Text(
                'Categories',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const GapH(1),
              BlocBuilder<CategoryTypeCubit, List<String>>(
                builder: (context, state) {
                  return categoriesTab(state);
                },
              ),
              BlocBuilder<CategoryTypeCubit, List<String>>(
                builder: (context, state) {
                  return BlocBuilder<CategoryIndexCubit, int>(
                    builder: (context, indexState) {
                      return IndexedStack(
                        index: indexState,
                        children: List.generate(
                          state.length,
                          (index) => _CategoryView(state[index]),
                        ),
                      );
                    },
                  );
                },
              ),
              BlocBuilder<ProductCubit, List<ProductModel>>(
                builder: (context, state) {
                  if (state.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Popular 🔥',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.productScreen,
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        shrinkWrap: true,
                        itemCount: state.length,
                        physics: const NeverScrollableScrollPhysics(),
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
                            child: _PopularProductTile(product: product),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  NotificationListener<OverscrollIndicatorNotification> categoriesTab(
    List<String> categories,
  ) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            categories.length,
            (index) {
              return BlocBuilder<CategoryIndexCubit, int>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      context.read<CategoryIndexCubit>().indexChanged(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                        top: 10,
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: state == index
                            ? AppColor.primaryColor
                            : AppColor.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                            color: AppColor.shadowColor,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: state == index
                              ? AppColor.white
                              : AppColor.primaryColor,
                          fontWeight: state == index
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PopularProductTile extends StatelessWidget {
  const _PopularProductTile({
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              product.image,
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
                Text(
                  '₹${product.price.toString()}',
                  style: const TextStyle(
                    fontSize: 17,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
              ],
            ),
          ),
          const SizedBox(width: 15),
          BlocBuilder<UserCartIdCubit, UserCartIdState>(
            builder: (context, state) {
              bool contain = state.pid.contains(product.pid);
              return Material(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(18),
                elevation: 3,
                shadowColor: AppColor.primaryColor.withOpacity(0.50),
                child: InkWell(
                  onTap: () {
                    if (contain) {
                      String cid = state.getCid(product.pid);
                      context.read<UserCartCubit>().removeCartProduct(cid);
                    } else {
                      context.read<UserCartCubit>().addCartItem(product);
                    }
                  },
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      contain ? Icons.shopping_bag_outlined : Icons.add,
                      size: 15,
                      color: AppColor.white,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoute.searchScreen);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(0, 4),
              color: AppColor.shadowColor,
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: AppColor.primaryColor,
              ),
              GapW(2),
              Text(
                'Search Coffee',
                style: TextStyle(
                  color: AppColor.hintTextColor,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryView extends StatelessWidget {
  final String type;
  const _CategoryView(this.type);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryProductCubit(context.read<FirebaseCloudService>())
            ..fetchProduct(type),
      child: const CategoryTile(),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductCubit, Stream<List<ProductModel>>?>(
      builder: (context, state) {
        if (state == null) {
          return Container();
        } else {
          return StreamBuilder<List<ProductModel>?>(
            stream: state,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container();
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    return NotificationListener<
                        OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              List.generate(snapshot.data!.length, (index) {
                            final product = snapshot.data![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.productDescriptionScreen,
                                  arguments: product,
                                );
                              },
                              child: CategoryProductTile(product: product),
                            );
                          }),
                        ),
                      ),
                    );
                  }
                  return Container();
                default:
                  return Container();
              }
            },
          );
        }
      },
    );
  }
}

class CategoryProductTile extends StatelessWidget {
  const CategoryProductTile({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(0, 2),
            color: AppColor.shadowColor,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.network(
              product.image,
              height: 40.w,
              width: 40.w,
              fit: BoxFit.cover,
            ),
          ),
          const GapH(0.5),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    BlocBuilder<UserCartIdCubit, UserCartIdState>(
                      builder: (context, state) {
                        bool contain = state.pid.contains(product.pid);
                        return Material(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(18),
                          elevation: 3,
                          shadowColor: AppColor.primaryColor.withOpacity(0.50),
                          child: InkWell(
                            onTap: () {
                              if (contain) {
                                String cid = state.getCid(product.pid);
                                context
                                    .read<UserCartCubit>()
                                    .removeCartProduct(cid);
                              } else {
                                context
                                    .read<UserCartCubit>()
                                    .addCartItem(product);
                              }
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(
                                contain
                                    ? Icons.shopping_bag_outlined
                                    : Icons.add,
                                size: 15,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
