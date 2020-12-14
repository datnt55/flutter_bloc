import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/banner_cubit.dart';


class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BannerCubit(repository: CatalogRepository()),
      child: BlocBuilder<BannerCubit, ResponseState<List<BannerData>>>(builder: (_, state) {
        if (state is LoadingState) {
          return BannerShimmerWidget();
        } else if (state is ErrorState) {
          return Builder(
            builder: (context) => Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/network_issue.png'),
                    FlatButton(
                      minWidth: 150,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.grey.withOpacity(0.2))),
                      child: Text('Retry'),
                      onPressed:() {
                        context.read<BannerCubit>().getBanner();
                      },
                    )
                  ],
                )
            ),
          );
        } else if (state is SuccessState<List<BannerData>>) {
          final banner = state.response;
          return Stack(
            children: [BlocProvider(create: (_) => BannerChangeCubit(), child: BannerSliderWidget(banner)),
            ],
          );
        }
        return Container();
      }),
    );
  }
}


class BannerSliderWidget extends StatefulWidget  {
  final PageController _pageController = new PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1,
  );
  final List<BannerData> banner;

  BannerSliderWidget(this.banner);

  @override
  _BannerState createState() => _BannerState(banner);
}

class _BannerState extends State<BannerSliderWidget> {
  final PageController _pageController = new PageController(
    initialPage: 0,
    keepPage: false,
    viewportFraction: 1,
  );
  Timer timer;
  final List<BannerData> banner;

  _BannerState(this.banner){
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      context.read<BannerChangeCubit>().incrementPage();
      _pageController.animateToPage(
        context.read<BannerChangeCubit>().page,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<BannerChangeCubit, int>(builder: (_, state) {
      return Container(
        child: BlocProvider(
          create: (_) => BannerScrollCubit(),
          child: BlocBuilder<BannerScrollCubit, double>(builder: (_, value) {
            return Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                        child: Opacity(
                          child: Image.network(
                            banner[state % banner.length].background,
                            fit: BoxFit.fill,
                          ),
                          opacity: 1,
                        ))),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 165,
                    margin: EdgeInsets.only(top: 130.0),
                    child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          context.read<BannerChangeCubit>().setPage(index);
                        },
                        itemBuilder: (context, index) => AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double _value = 0;
                            if (_pageController.position.haveDimensions) {
                              _value = _pageController.page - index;
                              _value = (1 - (_value.abs() * .9)).clamp(0.0, 1.0);
                            }
                            context.watch<BannerScrollCubit>().setOffset(_value);
                            print(_value);
                            return Opacity(
                              child: child,
                              opacity: _value,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 3)),
                              ],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              child: Image.network(
                                banner[index % banner.length].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )))
              ],
            );
          }),
        ),
      );
    }));
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    timer.cancel();
  }
}

class BannerShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child:Shimmer.fromColors(
              child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  )
              ),
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],)
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 170,
            margin: EdgeInsets.only(top: 115.0),
            child: Shimmer.fromColors(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 4, offset: Offset(0, 3)),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                    )
                ),
              ),
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],)
        )
      ],
    );
  }
}