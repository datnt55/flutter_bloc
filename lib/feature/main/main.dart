import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_f99/feature/main/navigation/main_screen.dart';
import 'package:flutter_app_f99/feature/main/navigation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    return BlocProvider(
        create: (_) => NavigationCubit(),
        child: BlocBuilder<NavigationCubit, int>(
            builder: (_, state) {
              return MaterialApp(home: MyHomePage(state),);
            }
        )
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage(this.state);

  final int state;

  Widget getScreenNavigation(){
    if (state == 0)
      return MainScreen();
    else
      return Center(
        child: Text('Screen $state'),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreenNavigation(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: state,
        selectedItemColor: Colors.amber[800],
        onTap: (index) => context.read<NavigationCubit>().setPage(index),
      ),
    );
  }
}
