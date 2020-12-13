import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/feature/product/product_detail_cubit.dart';
import 'package:flutter_app_f99/network/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/product_detail_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) => ProductDetailCubit(
              repository: CatalogRepository(), productId: productId.toString()),
          child: BlocBuilder<ProductDetailCubit, ResponseState<ProductDetail>>(
              builder: (_, state) {
            if (state is LoadingState) {
              return Container();
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
                              side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2))),
                          child: Text('Retry'),
                          onPressed: () {
                            context
                                .read<ProductDetailCubit>()
                                .getProductDetail();
                          },
                        )
                      ],
                    )),
              );
            } else if (state is SuccessState<ProductDetail>) {
              final product = state.response;
              return ProductDetailWidget(
                product: product,
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

class ProductDetailWidget extends StatelessWidget {
  ProductDetailWidget({this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CarouselSlider.builder(
          itemBuilder: (BuildContext context, int index) {
            return  CachedNetworkImage(
              imageUrl: product.imageUrls[index],
              placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 500,
              fit: BoxFit.fitWidth,
            );
          },
          options: CarouselOptions(
            viewportFraction: 1.0,
            height: MediaQuery.of(context).size.width,
            enableInfiniteScroll: true,
          ), itemCount:  product.imageUrls.length,

        )
      ),
    );
  }
}
