
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/network/repository/seller_repository.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/product_detail_response.dart';
import 'package:flutter_app_f99/network/response/product_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_app_f99/network/response/seller_detail_response.dart';
import 'package:flutter_app_f99/network/response/session_product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerDetailCubit extends Cubit<ResponseState<SellerDetail>> {
  SellerDetailCubit({this.repository, this.sellerId}) : super(InitialState()){
    getSellerDetail();
  }

  final SellerRepository repository;

  final String sellerId;

  void getSellerDetail() async {
    try {
      emit(LoadingState());
      final data = await repository.getSellerInfo(sellerId.toString());
      emit(SuccessState(data));
    } catch (e) {
      //emit(ErrorState());
    }
  }

}