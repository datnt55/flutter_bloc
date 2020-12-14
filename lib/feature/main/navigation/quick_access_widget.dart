import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/model/home_item.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/banner_cubit.dart';
import 'bloc/quick_access_cubit.dart';


class QuickAccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuickAccessCubit(repository: CatalogRepository()),
      child: BlocBuilder<QuickAccessCubit, ResponseState<List<QuickAccessData>>>(builder: (_, state) {
        if (state is LoadingState) {
          return ShimmerQuick();
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
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        if (index % 5 == 0) {
                          return Container(
                              padding: EdgeInsets.only(right: 8,top: 4, bottom: 4),
                              width: (MediaQuery.of(context).size.width - 48) / 5- 4,
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: data[index].image,
                                    placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
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
                                  CachedNetworkImage(
                                    imageUrl: data[index].image,
                                    placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
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
                                  CachedNetworkImage(
                                    imageUrl: data[index].image,
                                    placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.fill,
                                  ),
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

class ShimmerQuick extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (index % 5 == 0) {
                    return Shimmer.fromColors(child: Container(
                        padding: EdgeInsets.only(right: 8,top: 4, bottom: 4),
                        width: (MediaQuery.of(context).size.width - 48) / 5- 4,
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            SizedBox(width : 200,height: 16, child: Container(color: Colors.white,),),
                          ],
                        ),
                      ),
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],);
                  }else if (index % 5 == 4) {
                    return Shimmer.fromColors(child: Container(
                        padding:EdgeInsets.only(left: 8,top: 4, bottom: 4),
                        width: (MediaQuery.of(context).size.width - 48) / 5 - 4,
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            SizedBox(width : 200,height: 16, child: Container(color: Colors.white,),),
                          ],
                        ),
                    ),
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],);
                  }else{
                    return Shimmer.fromColors(child: Container(
                        padding:EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        width: (MediaQuery.of(context).size.width - 48) / 5 + 2,
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          SizedBox(width : 200,height: 16, child: Container(color: Colors.white,),),
                        ],
                      ),
                    ),
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
