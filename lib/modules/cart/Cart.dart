import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/main.dart';
import 'package:onmarket_task/modules/appcubit/cubit.dart';
import 'package:onmarket_task/modules/splash/splash.dart';
import 'package:onmarket_task/widgets/OrderWidget.dart';
import 'package:onmarket_task/widgets/SharedWidgets.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  var appCubit;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appCubit = BlocProvider.of<AppCubit>(context);

  }

  @override
  Widget build(BuildContext context) {

    double _gridSize = MediaQuery.of(context).size.height*0.88;

    return Container(height: MediaQuery.of(context).size.height, child:
        new Stack(children: <Widget>[
        new Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
        new Container(margin: EdgeInsets.symmetric(horizontal: 20), height: _gridSize,
                    width: double.infinity, child:
                    new Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      new Padding(padding: EdgeInsets.symmetric(vertical: 40), child:
                      new Text("\$himaa \$hop", style: TextStyle(color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))
                      ),
                      appCubit.currentCart.orders.isNotEmpty?
                      new Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap:(){
                            appCubit.emptyCart();
                          },
                          child: Text("Clear Cart", style: TextStyle(color: Colors.red.shade300,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                        ),
                      ):Text(""),
                     new ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                      appCubit.currentCart.orders.length,
                          itemBuilder: (context, index ){
                            print(appCubit.currentCart);
                            return Dismissible(
                              background: Container(color: Colors.transparent),
                              key: Key(appCubit.currentCart.orders[index].id.toString()),
                              onDismissed: (_) {
                                appCubit..removerOrderOfCart(appCubit.currentCart.orders[index]);
                              },
                              child: new Padding(padding: EdgeInsets.symmetric(vertical: 10),
                                  child: new OrderWidget(appCubit.currentCart.orders[index], _gridSize)),
                            );
                          }),
                      Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                        new Text("Total", style: TextStyle(color: Colors.white, fontSize: 20)),
                        new Text("\$${appCubit.currentCart.totalPrice().toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ])

                    ])
            )
      ]),
      new Align(alignment: Alignment.bottomLeft, child:
      new Container(padding: EdgeInsets.only(left: 10, bottom: _gridSize*0.02), width:
      MediaQuery.of(context).size.width - 80, child:
      new RaisedButton(color: Colors.amber, shape: RoundedRectangleBorder(borderRadius:
      BorderRadius.circular(60)), padding: EdgeInsets.all(20),
          onPressed: (){
            if(appCubit.currentCart.isEmpty){
              showToast(msg: "You have no items in cart");
            }else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              new Splash(isOpening: false)));
            }
          },
          child: new Text("Check Out",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))
      )
      )
      )
    ])
    );
  }}