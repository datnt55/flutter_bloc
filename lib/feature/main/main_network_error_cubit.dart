import 'package:bloc/bloc.dart';
class MainNetworkCubit extends Cubit<bool> {

  MainNetworkCubit() : super(false);


  void setError(bool error) {
    emit(error);
  }
}
