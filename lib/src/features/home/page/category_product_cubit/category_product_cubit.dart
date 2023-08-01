import 'package:bloc/bloc.dart';
import 'package:unicorn_cafe/src/model/product_model.dart';
import 'package:unicorn_cafe/src/services/firebase_cloud_services.dart';

class CategoryProductCubit extends Cubit<Stream<List<ProductModel>>?> {
  final FirebaseCloudService _firebaseCloudService;

  CategoryProductCubit(FirebaseCloudService firebaseCloudService)
      : _firebaseCloudService = firebaseCloudService,
        super(null);

  void fetchProduct(String type) {
    emit(_firebaseCloudService.getSpecificTypeProduct(type));
  }
}
