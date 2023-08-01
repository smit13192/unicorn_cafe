import 'package:bloc/bloc.dart';

class CategoryIndexCubit extends Cubit<int> {
  CategoryIndexCubit() : super(0);

  void indexChanged(int index) {
    emit(index);
  }
}
