
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_f99/feature/location/location_selector_screen.dart';
import 'package:flutter_app_f99/feature/main/navigation/banner_widget.dart';
import 'package:flutter_app_f99/feature/main/navigation/quick_access_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                  itemBuilder: (context, index){
                    if (index == 0)
                      return BannerWidget();
                    else if (index == 1)
                      return QuickAccessWidget();
                    else
                      return Container(child: Text("Item $index"),);
                  }),
              SearchWidget(),
            ],
          )
      )
    );
  }
}

class SearchWidget extends StatelessWidget {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: 24, right: 24,top: 32),
             width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => LocationSelectorScreen()),);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white,),
                              Text('Hà nội', style: TextStyle(color: Colors.white),),
                              Icon(Icons.keyboard_arrow_down, color: Colors.white,)
                            ],
                          ),
                        )
                        ,flex: 5,
                      ),
                      Flexible(child: Icon(Icons.shopping_cart_outlined, color: Colors.white,), flex: 1,),
                      Flexible(child: Icon(Icons.messenger_outline_rounded, color: Colors.white), flex: 1,),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              new Flexible(child: Icon(Icons.search, color: Colors.grey,), flex: 1,),
                              new Flexible(
                                fit: FlexFit.tight,
                                child:
                                Text('Search on F99', style: TextStyle(color: Colors.grey),), flex: 7,
                              ),
                            ],
                          )),
                    )
                )
              ],
            )
    );
  }
}