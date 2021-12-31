import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/modules/appcubit/cubit.dart';
import 'package:onmarket_task/modules/home/home.dart';

class Splash extends StatefulWidget {

  final bool isOpening;

  const Splash({Key? key, required this.isOpening}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  var appCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appCubit = BlocProvider.of<AppCubit>(context);

    if(!widget.isOpening){
      appCubit.currentCart.orders.clear();
    }

    Timer(
        Duration(seconds: widget.isOpening?5:3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
            Home())));
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child:widget.isOpening?TextLiquidFill(
            text: "\$himaa \$hop",
            waveColor: Colors.amber,
            boxBackgroundColor: Colors.black,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
                fontSize: width/8,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            boxHeight: 300.0,
          ):
          new Text("Your order has been placed successfully",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight:
              FontWeight.bold, color: Colors.amber, fontSize: width/10)),
        ),

        //   Container(
      //   decoration: new BoxDecoration(
      //   image: new DecorationImage(
      //   image: new AssetImage("assets/gifs/${widget.isOpening?"opening.gif":"checkout.gif"}",),
      //     fit: widget.isOpening?BoxFit.fill:BoxFit.contain,
      //     ),
      //   ),
      // ),
    ));
  }
}