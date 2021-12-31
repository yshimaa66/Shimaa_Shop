import 'package:flutter/material.dart';
import 'package:onmarket_task/models/Order.dart';
import 'package:onmarket_task/modules/productview/ProductView.dart';

class OrderWidget extends StatelessWidget {

  final Order _order;
  final double _gridSize;
  OrderWidget(this._order, this._gridSize);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //appCubit.addOrderToCart(this.widget.product, 1);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
        new ProductView(product: this._order.product)));
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.15),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            new ClipOval(child:
              new Container(color: Colors.white,
                  child: new Image.asset(this._order.product.urlToImage),
                  height:  (MediaQuery.of(context).size.height - _gridSize)* 0.5)
            ),
            new Padding(padding: EdgeInsets.symmetric(horizontal: 10), child:
              new Text(this._order.quantity.toString(), style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold))
            ),
            new Text("x", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            new Flexible(flex: 2, child:
              new Padding(padding: EdgeInsets.symmetric(horizontal: 10), child:
                new Text(this._order.product.title,
                    style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold))
              )
            ),
            new Flexible(flex: 1, child:
              new Text("\$${this._order.orderPrice.toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
            )
          ]),
      ),
      ),
    );
  }

}