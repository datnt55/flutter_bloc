import 'package:bloc/bloc.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';

class BannerCubit extends Cubit<ResponseState<List<BannerData>>> {
  BannerCubit({this.repository}) : super(InitialState()){
    getBanner();
  }

  final CatalogRepository repository;

  int currentPage = 0;

  void getBanner() async {
    try {
      emit(LoadingState());
      final banner = await repository.getBanner();
      emit(SuccessState(banner));
    } catch (e) {
      emit(ErrorState());
    }
  }

}


class BannerChangeCubit extends Cubit<int> {
  BannerChangeCubit() : super(0);

  int page = 0;


  void setPage(int current) {
    page = current;

    emit(page);
  }

  void incrementPage() {
    page++;
    emit(page);
  }
}

class BannerScrollCubit extends Cubit<double> {
  BannerScrollCubit() : super(0);

  double offset = 0.0;

  void setOffset(double value){
    this.offset = value;
    emit(offset);
  }
}

