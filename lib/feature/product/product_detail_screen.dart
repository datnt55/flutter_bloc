import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_f99/base/response_state.dart';
import 'package:flutter_app_f99/feature/product/product_detail_cubit.dart';
import 'package:flutter_app_f99/feature/product/product_seller_cubit.dart';
import 'package:flutter_app_f99/network/repository/seller_repository.dart';
import 'file:///D:/Android/flutter/Example/clone_f99/flutter_bloc/lib/network/repository/catalog_repository.dart';
import 'package:flutter_app_f99/network/response/product_detail_response.dart';
import 'package:flutter_app_f99/network/response/seller_detail_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (_) =>
              ProductDetailCubit(
                  repository: CatalogRepository(), productId: productId.toString()),
          child: BlocBuilder<ProductDetailCubit, ResponseState<ProductDetail>>(
              builder: (_, state) {
                if (state is LoadingState) {
                  return Container();
                } else if (state is ErrorState) {
                  return Builder(
                    builder: (context) =>
                        Container(
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

class ProductDetailWidget extends StatefulWidget {
  ProductDetailWidget({this.product});

  final ProductDetail product;

  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetailWidget> {

  final ProductDetail product;

  _ProductDetailState(this.product);

  int slideIndex = 0;

  final oCcy = new NumberFormat("#,##0", "en_US");

  final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      this.slideIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: CarouselSlider.builder(
                  carouselController: _controller,
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      imageUrl: product.imageUrls[index],
                      placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 500,
                      fit: BoxFit.fitWidth,
                    );
                  },
                  options: CarouselOptions(
                      viewportFraction: 1.0,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width,
                      enableInfiniteScroll: true,
                      onPageChanged: onPageChange
                  ), itemCount: product.imageUrls.length,

                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.imageUrls.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (slideIndex == index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrls[index],
                            placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            height: 40.0,
                            width: 40.0,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () {
                        setState(() {
                          slideIndex = index;
                        });
                        _controller.animateToPage(index);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrls[index],
                            placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            height: 40.0,
                            width: 40.0,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    );
                  },

                ),
              ),
              SeparateWidget(6.0),
              Padding(
                  padding: EdgeInsets.only(top: 16, left: 16),
                  child: Text(product.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)
              ),

              Padding(
                  padding: EdgeInsets.only(bottom: 16, left: 16, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${oCcy.format(product.price)}đ',
                          style: TextStyle(color: Colors.green.shade700, fontSize: 16, fontWeight: FontWeight.w500)),

                      Flexible(
                          child: Container(
                            child: Text('/${product.unit}', style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                          )
                      )
                    ],
                  )
              ),
              SeparateWidget(6.0),
              Padding(
                  padding: EdgeInsets.only(top: 16, left: 16),
                  child: Text('Seller', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),)
              ),
              SellerInformationWidget(product.sellerId),
              SeparateWidget(6.0),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return VariantBottomSheetWidget(product);
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select Variant', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                        Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,)
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class VariantBottomSheetWidget extends StatelessWidget {
  final oCcy = new NumberFormat("#,##0", "en_US");

  VariantBottomSheetWidget(this.product);

  final ProductDetail product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Text('Select Quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
              ),
              Container(
                margin: EdgeInsets.only(right: 24),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 24,top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrls[0],
                    placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(width: 8,),
                Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          SeparateWidget(1.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: product.variants.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.variants[index].name, style: TextStyle(fontSize: 16),maxLines: 1, overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('${oCcy.format(product.variants[index].price)}đ',
                                style: TextStyle(color: Colors.green.shade700, fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          Row(
                            children: [
                              Icon(Icons.remove_circle, color: Colors.green.shade200,),
                              SizedBox(width: 4,),
                              Text('1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                              SizedBox(width: 4,),
                              Icon(Icons.add_circle, color: Colors.lightGreenAccent.shade700,)
                            ],
                          )

                        ],
                      )

                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },

            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(24),
              topRight: const Radius.circular(24)
          )
      ),
    );
  }
}

class SeparateWidget extends StatelessWidget {

  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: height,
      color: Colors.grey.shade200,);
  }

  SeparateWidget(this.height);

}

class SellerInformationWidget extends StatelessWidget {
  SellerInformationWidget(this.sellerId);

  final int sellerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SellerDetailCubit(repository: SellerRepository(), sellerId: sellerId.toString()),
        child: BlocBuilder<SellerDetailCubit, ResponseState<SellerDetail>>(builder: (_, state) {
          if (state is LoadingState) {
            return Container();
          } else if (state is ErrorState) {
            return Container();
          } else if (state is SuccessState<SellerDetail>) {
            final seller = state.response;
            return Container(
              margin: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CachedNetworkImage(
                      imageUrl: seller.data.logo,
                      placeholder: (context, url) => Image.asset('assets/images/img_loading.png'),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 35.0,
                      width: 35.0,
                      fit: BoxFit.fitHeight,
                    ), flex: 1,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(seller.data.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        SizedBox(height: 4,),
                        Text(seller.data.headQuarter, style: TextStyle(color: Colors.black54, fontSize: 13), maxLines: 2, overflow: TextOverflow
                            .ellipsis,),
                      ],
                    ), flex: 3,),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(28.0)
                      ),
                      child: Text('View Shop', style: TextStyle(color: Colors.green, fontSize: 12),),
                    ), flex: 1,)
                ],
              ),
            );
          }
          return Container();
        })
    );
  }
}



