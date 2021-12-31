import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/models/Product.dart';
import 'package:onmarket_task/modules/appcubit/cubit.dart';
import 'package:onmarket_task/modules/productview/ProductView.dart';

class ProductWidget extends StatefulWidget {

  final Product product;


  ProductWidget({Key ?key, required this.product}) : super(key:key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {

  var appCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appCubit = BlocProvider.of<AppCubit>(context);

  }

  @override
  Widget build(BuildContext context){

    double height = MediaQuery.of(context).size.height/1.2;
    double fontSize = (height/30).round().toDouble();

    return new GestureDetector(
        onTap: (){
          //appCubit.addOrderToCart(this.widget.product, 1);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          new ProductView(product: widget.product)));
        },
        child:
          new Container(padding: EdgeInsets.fromLTRB(20, 20, 20, 5),decoration:
          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
              child: new Column(mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              new Center(child: new Hero(tag: "tagHero${this.widget.product.id}",
                  child: new Image.asset(this.widget.product.urlToImage,
                      fit: BoxFit.cover, height: height * 0.20))),
              new Container(height: height * 0.25, margin: EdgeInsets.only(top: 10), child:
                new Column(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text("\$${this.widget.product.price}", style: TextStyle(fontWeight:
                      FontWeight.bold, color: Colors.black, fontSize: fontSize)),

                      this.widget.product.discount!=0?Container(
                        decoration:
                        BoxDecoration(color: Colors.red.shade100,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              new Text("${widget.product.discount}%",
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
                  new Container(margin: EdgeInsets.only(top: 20, bottom: 10),
                      child: new Text("${this.widget.product.title}",
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black, fontSize: fontSize * 0.65))),
                  new Text("${this.widget.product.weight} g",
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.grey, fontSize: fontSize * 0.48))
                ])
              )
            ])
          )
    );
  }
}