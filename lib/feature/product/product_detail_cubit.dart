
import 'package:flutter_app_f99/base/response_state.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/product_detail_response.dart';
import 'package:flutter_app_f99/network/response/product_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_app_f99/network/response/session_product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<ResponseState<ProductDetail>> {
  ProductDetailCubit({this.repository, this.productId}) : super(InitialState()){
    getProductDetail();
  }

  final CatalogRepository repository;

  final String productId;

  void getProductDetail() async {
    try {
      emit(LoadingState());
      final data = await repository.getProductDetail(productId);
      emit(SuccessState(data));
    } catch (e) {
      //emit(ErrorState());
    }
  }

}