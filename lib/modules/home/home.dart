import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/main.dart';
import 'package:onmarket_task/modules/appcubit/cubit.dart';
import 'package:onmarket_task/modules/cart/Cart.dart' as Cart;
import 'package:onmarket_task/modules/gridshop/GridShop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _showCart = false;

  ScrollController _scrollController = new ScrollController();

  var appCubit;


  @override
  initState(){
    _scrollController = new ScrollController();
    appCubit = BlocProvider.of<AppCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(backgroundColor: Colors.black, body:
    new Stack(children: <Widget>[
      new CustomScrollView(physics: NeverScrollableScrollPhysics(),
          controller: _scrollController, slivers: <Widget>[
            new SliverToBoxAdapter(child:
            new GridShop()
            ),
            new SliverToBoxAdapter(child:
            new Cart.Cart()
            ),
          ]),
      new Align(alignment: Alignment.bottomRight, child:
      new Container(margin: EdgeInsets.only(right: 10, bottom: 10),child:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: width/80, vertical: height/100),
        child: new FloatingActionButton(
          onPressed: (){
          if(_showCart){
            _scrollController.animateTo(_scrollController.position.minScrollExtent,
                curve: Curves.fastOutSlowIn, duration: Duration(seconds: 2));
          } else {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                curve: Curves.fastOutSlowIn, duration: Duration(seconds: 2));
          }
          setState(() {
            _showCart = !_showCart;
          });

        }, backgroundColor: Colors.amber,
            child: Column(
                children: [
                  appCubit.currentCart.orders.isNotEmpty && !_showCart?Padding(
                    padding: EdgeInsets.symmetric(vertical: height/180),
                    child: Text(appCubit.currentCart.orders.length.toString(),
                      style: TextStyle(color: Colors.black),),
                  ):Text(""),
                  new Icon(_showCart ? Icons.close :
                  Icons.shopping_cart,color: Colors.white,),
                ],
              ),
            )),
      )
      )

    ])
    );
  }
}
