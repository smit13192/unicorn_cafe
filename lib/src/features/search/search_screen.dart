import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_cubit/user_cart_cubit.dart';
import 'package:unicorn_cafe/src/features/cart/user_cart_id_cubit/user_cart_id_cubit.dart';
import 'package:unicorn_cafe/src/features/search/cubit/search_cubit.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';
import 'package:unicorn_cafe/src/widget/product_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        firebaseCloudService: context.read<FirebaseCloudService>(),
      )..getAllProducts(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackgroundColor,
      body: Column(
        children: [
          const GapH(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                    color: AppColor.shadowColor,
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextFormField(
                focusNode: focusNode,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10),
                    child: Icon(Icons.search),
                  ),
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Serach Coffee',
                  hintStyle: const TextStyle(
                    color: AppColor.hintTextColor,
                    fontSize: 15,
                  ),
                ),
                onChanged: (value) {
                  context.read<SearchCubit>().queryChange(value.trim());
                },
                onFieldSubmitted: (value) {
                  List<ProductModel> products =
                      context.read<SearchCubit>().state.filterProduct;
                  Navigator.of(context)
                      .pushNamed(AppRoute.productScreen, arguments: products);
                },
              ),
            ),
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state.query.isEmpty) {
                return Container();
              } else if (state.filterProduct.isEmpty) {
                return Container();
              } else {
                return Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator();
                      return true;
                    },
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 50.w,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: state.filterProduct.length,
                      itemBuilder: (context, index) {
                        ProductModel product = state.filterProduct[index];
                        return BlocBuilder<UserCartIdCubit, UserCartIdState>(
                          builder: (context, state) {
                            bool contain = state.pid.contains(product.pid);
                            return ProductTile(
                              product: product,
                              onPressed: () {
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
                              icon: contain
                                  ? Icons.shopping_bag_outlined
                                  : Icons.add,
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
