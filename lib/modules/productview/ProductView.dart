import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/main.dart';
import 'package:onmarket_task/models/Order.dart';
import 'package:onmarket_task/models/Product.dart';
import 'package:onmarket_task/modules/appcubit/cubit.dart';
import 'package:onmarket_task/widgets/SharedWidgets.dart';

class ProductView extends StatefulWidget{

  final Product product;
  ProductView({Key ?key, required this.product}) : super(key:key);

  @override
  _ProductView createState() => new _ProductView();
}

class _ProductView extends State<ProductView> {


  int _quantity = 0;

  var appCubit;

  bool _isFav = false;


  void _increment(){
    setState(() {
      _quantity++;
    });
  }

  void _decrement(){
    if(_quantity>1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void toggleIsFav(){
   setState(() {
     _isFav = !_isFav;
   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appCubit = BlocProvider.of<AppCubit>(context);

    _quantity = appCubit.getOrderQuantityInCart(widget.product);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(backgroundColor: Colors.white,
        appBar: new AppBar(backgroundColor: Colors.white,
            elevation: 0, iconTheme: IconThemeData(color: Colors.black)), body:
        new SafeArea(child:
          new Column(children: <Widget>[
            new Container(padding: EdgeInsets.symmetric(horizontal: 20), height: MediaQuery.of(context).size.height*0.73, child:
              new SingleChildScrollView(child:
                new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  new Center(child:
                    new Hero(tag:"tagHero${widget.product.id}", child:
                        new Image.asset(widget.product.urlToImage,
                            fit: BoxFit.cover, height: MediaQuery.of(context).size.height*0.4)
                  ),),
                  new Container(margin: EdgeInsets.only(top: 20), child:
                    new Text(widget.product.title, style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20, color: Colors.black)),
                  ),
                  new Container(margin: EdgeInsets.only(top: 10), child:
                    new Text("${widget.product.weight} g", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey)),
                  ),
                  new Container(margin: EdgeInsets.only(top: 20), child:
                      new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                        new Container(padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(50)), child:
                          new Row(children: <Widget>[
                            new InkWell(
                              child: new Icon(Icons.remove, size: 15,color: Colors.black54,),
                              onTap: _decrement,
                            ),
                            new Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                                child: new Text(_quantity.toString(),
                                    style: TextStyle(fontSize: 20,color: Colors.black87))),
                            new InkWell(
                              child: new Icon(Icons.add, size: 15,color: Colors.black54),
                              onTap: _increment,
                            ),
                          ]),
                        ),
                        Column(
                          children: [

                            new Text("\$${(widget.product.price).toStringAsFixed(2)}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),

                            widget.product.discount!=0?Container(
                              width: 100,
                              decoration:
                              BoxDecoration(color: Colors.red.shade100,
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    new Text("${this.widget.product.discount}%",
                                        style: TextStyle(fontWeight:
                                        FontWeight.normal, color: Colors.red, fontSize: 14)),

                                    new Text("\$${(widget.product.price
                                        *(widget.product.discount/100)+widget.product.price).toStringAsFixed(2)}",
                                        style: TextStyle(fontWeight:
                                        FontWeight.normal,  decoration: TextDecoration.lineThrough,
                                            color: Colors.grey, fontSize: 13)),

                                  ],
                                ),
                              ),
                            ):Text(""),

                          ],
                        ),
                      ])
                  ),
                  new Container(margin: EdgeInsets.only(top: 40, bottom: 40), child:
                    new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      new Text("About the product:", style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold, fontSize: 20)),
                      new Padding(padding: EdgeInsets.only(top: 10), child:
                      new Text(widget.product.about, style: TextStyle(color: Colors.grey, fontSize: 18)))
                    ])
                  )
                ])
              )
            ),
            new Container(decoration: BoxDecoration(boxShadow:  [
              BoxShadow(
                color: Colors.white,
                blurRadius: 30.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  0.0, // horizontal, move right 10
                  -20.0, // vertical, move down 10
                ),
              )
            ]), padding: EdgeInsets.symmetric(horizontal: 20), height: MediaQuery.of(context).size.height*0.1, child:
              new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Column(
                  children: [
                    new FlatButton.icon(onPressed: (){
                        toggleIsFav();
                    },
                        icon: new Icon(_isFav?Icons.favorite
                        :Icons.favorite_border,color: Colors.black,),
                        label: new Text("")),


                    Text(_isFav?
                    "U loved this":"Tap to love",
                        style: TextStyle(fontWeight: FontWeight.bold))

                  ],
                ),
                new SizedBox(width: MediaQuery.of(context).size.width * 0.6, child:
                  new RaisedButton(color: Colors.amber,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                      padding: EdgeInsets.all(20),
                      onPressed: (){
                        if(_quantity!=0) {
                          appCubit.addOrderToCart(widget.product, _quantity);
                          print("currentCart.orders.length ${appCubit
                              .currentCart.orders.length}");
                          Navigator.of(context).pop();
                        }else{
                          showToast(msg: "Please, the desired quantity");
                        }
                      },
                      child: new Text("Add to cart", style: TextStyle(fontWeight: FontWeight.bold))
                  )
                )
              ]),
            )
          ])
      )
    );

 }}
