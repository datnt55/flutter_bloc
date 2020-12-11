import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/network/catalog_api_client.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/banner_cubit.dart';
import 'bloc/quick_access_cubit.dart';


class QuickAccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuickAccessCubit(repository: CatalogRepository()),
      child: BlocBuilder<QuickAccessCubit, ResponseState<List<QuickAccessData>>>(builder: (_, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
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
        } else if (state is SuccessState<List<QuickAccessData>>) {
          final data = state.response;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (index % 5 == 0) {
                          return Container(
                              padding: EdgeInsets.only(right: 8,top: 4, bottom: 4),
                              width: (MediaQuery.of(context).size.width - 48) / 5- 4,
                              child: Column(
                                children: [
                                  Image.network(data[index].image, fit: BoxFit.fill,),
                                  SizedBox(height: 8),
                                  Text(data[index].name, textAlign: TextAlign.center,)
                                ],
                              )
                          );
                        }else if (index % 5 == 4) {
                          return Container(
                              padding:EdgeInsets.only(left: 8,top: 4, bottom: 4),
                              width: (MediaQuery.of(context).size.width - 48) / 5 - 4,
                              child: Column(
                                children: [
                                  Image.network(data[index].image, fit: BoxFit.fill,),
                                  SizedBox(height: 8),
                                  Text(data[index].name, textAlign: TextAlign.center,)
                                ],
                              )
                          );
                        }else{
                          return Container(
                              padding:EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              width: (MediaQuery.of(context).size.width - 48) / 5 + 2,
                              child: Column(
                                children: [
                                  Image.network(data[index].image, fit: BoxFit.fill,),
                                  SizedBox(height: 8),
                                  Text(data[index].name, textAlign: TextAlign.center,)
                                ],
                              )
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
