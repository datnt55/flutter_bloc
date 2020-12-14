import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/feature/main/navigation/bloc/session_list_cubit.dart';
import 'package:flutter_app_f99/feature/main/navigation/product_widget.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_app_f99/network/response/session_product_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'bloc/banner_cubit.dart';
import 'bloc/quick_access_cubit.dart';


class SessionProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionHomeCubit(repository: CatalogRepository()),
      child: BlocBuilder<SessionHomeCubit, ResponseState<List<SessionData>>>(builder: (_, state) {
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
        } else if (state is SuccessState<List<SessionData>>) {
          final data = state.response;
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 24), child:
                            Text(data[index].name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),),
                            Padding(padding: EdgeInsets.only(right: 24), child: Text('View more', style: TextStyle(color: Colors.green),),)
                          ],
                        ),
                        Builder(builder: (context){
                          if (data[index].description.isEmpty){
                            return SizedBox(height: 16,);
                          }
                          return Container(
                            margin: EdgeInsets.only(top: 2, bottom: 24),
                            child: Padding(padding: EdgeInsets.only(left: 24), child:  Text(data[index].description, style: TextStyle(color: Colors.grey.shade600,fontStyle: FontStyle.italic)),
                          ));
                        }),
                        ProductWidget(target: data[index].target,),
                      ],
                    ),
                  );
              });
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
