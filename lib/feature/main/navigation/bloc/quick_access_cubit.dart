
import 'package:flutter_app_f99/base/response_state.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickAccessCubit extends Cubit<ResponseState<List<QuickAccessData>>> {
  QuickAccessCubit({this.repository}) : super(InitialState()){
    getQuickAccess();
  }

  final CatalogRepository repository;

  int currentPage = 0;

  void getQuickAccess() async {
    try {
      emit(LoadingState());
      final data = await repository.getQuickAccess();
      emit(SuccessState(data));
    } catch (e) {
      emit(ErrorState());
    }
  }

}