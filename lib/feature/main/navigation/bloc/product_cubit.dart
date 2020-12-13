
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/network/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/product_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_app_f99/network/response/session_product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ResponseState<List<Product>>> {
  ProductCubit({this.repository, this.categoryId}) : super(InitialState()){
    getListProductOfCollection();
  }

  final CatalogRepository repository;

  final String categoryId;

  void getListProductOfCollection() async {
    try {
      emit(LoadingState());
      final data = await repository.getListProductOfCollection(categoryId);
      emit(SuccessState(data));
    } catch (e) {
      //emit(ErrorState());
    }
  }

}