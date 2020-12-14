import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/feature/product/product_detail_screen.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/product_cubit.dart';
import 'bloc/quick_access_cubit.dart';


class ProductWidget extends StatelessWidget {
  ProductWidget({this.target});
  final oCcy = new NumberFormat("#,##0", "en_US");
  final String target;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(repository: CatalogRepository(), categoryId: target),
      child: BlocBuilder<ProductCubit, ResponseState<List<Product>>>(builder: (_, state) {
        if (state is LoadingState) {
          return ShimmerSessionInHome();
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
                        context.read<QuickAccessCubit>().getQuickAccess();
                      },
                    )
                  ],
                )
            ),
          );
        } else if (state is SuccessState<List<Product>>) {
          final data = state.response;
          return  Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            margin: EdgeInsets.only(left: 16),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => ProductDetailScreen(productId: data[index].id,)),);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 135.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 210,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: data[index].imageUrl,
                                    placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    height: 135.0,
                                    width: 135.0,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Text(data[index].name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),),
                                SizedBox(height: 8,),
                                Text(data[index].getVariantsInfo(), style: TextStyle(color: Colors.grey.shade500, fontSize: 12),maxLines: 1, overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${oCcy.format(data[index].price)}đ', style: TextStyle(color: Colors.green.shade700, fontSize: 14, fontWeight: FontWeight.bold)),

                                  Flexible(
                                      child: Container(
                                        child: Text( '/${data[index].unit}', style: TextStyle(color: Colors.grey.shade500, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis,),
                                      )
                                  )
                                ],
                              ), flex: 4,
                              )
                             ,
                              Flexible(
                                child:  Icon(Icons.add_circle_outlined, color: Colors.green.shade700,size: 30,), flex: 1,
                              )

                            ],
                          )
                        ],
                      ),

                    ),
                  );
                }),
          );
        }
        return Container();
      }),
    );
  }
}

class ShimmerSessionInHome extends StatelessWidget{
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
