import 'package:bloc/bloc.dart';
class NavigationCubit extends Cubit<int> {

  NavigationCubit() : super(0);

  int page = 0;

  void setPage(int current) {
    page = current;

    emit(page);
  }
}
