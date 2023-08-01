import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/home/page/category_index_cubit/category_index_cubit.dart';
import 'package:unicorn_cafe/src/features/home/page/category_product_cubit/category_product_cubit.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryIndexCubit(),
      child: _ProductView(),
    );
  }
}

class _ProductView extends StatelessWidget {
  _ProductView();

  final List<String> categories = [
    'Cappuccino',
    'Americano',
    'Thick Shake',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
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
            categoriesTab(),
            BlocBuilder<CategoryIndexCubit, int>(
              builder: (context, state) {
                return IndexedStack(
                  index: state,
                  children: List.generate(
                    categories.length,
                    (index) => _CategoryTile(categories[index]),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  NotificationListener<OverscrollIndicatorNotification> categoriesTab() {
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
                            offset: const Offset(0, 4),
                            color: AppColor.shadowColor,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: state == index
                              ? Colors.white
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

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String type;
  const _CategoryTile(this.type);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryProductCubit(context.read<FirebaseCloudService>())
            ..fetchProduct(type),
      child: const _CategoryView(),
    );
  }
}

class _CategoryView extends StatelessWidget {
  const _CategoryView();

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
                            return CategoryProductTile(product: product);
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
      width: 38.92.w,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: AppColor.shadowColor,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            child: Image.network(
              product.image,
              height: 38.92.w,
              width: 38.92.w,
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
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 15,
                        color: AppColor.white,
                      ),
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
