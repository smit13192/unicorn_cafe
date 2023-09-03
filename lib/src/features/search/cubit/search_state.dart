// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String query;
  final List<ProductModel> allProducts;
  final List<ProductModel> filterProduct;

  const SearchState.initState({
    this.query = '',
    this.allProducts = const [],
    this.filterProduct = const [],
  });

  const SearchState({
    required this.query,
    required this.allProducts,
    required this.filterProduct,
  });

  SearchState copyWith({
    String? query,
    List<ProductModel>? allProducts,
    List<ProductModel>? filterProduct,
  }) {
    return SearchState(
      query: query ?? this.query,
      allProducts: allProducts ?? this.allProducts,
      filterProduct: filterProduct ?? this.filterProduct,
    );
  }
  
  @override
  List<Object?> get props => [query, allProducts, filterProduct];
}
