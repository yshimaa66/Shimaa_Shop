import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/modules/appcubit/cubit.dart';
import 'package:onmarket_task/modules/appcubit/states.dart';
import 'package:onmarket_task/modules/home/home.dart';
import 'package:onmarket_task/modules/splash/splash.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  new BlocProvider<AppCubit>(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) async {},
    builder: (context, state)=> MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnMarket Task',
      theme: ThemeData.dark(),
      home: Splash(isOpening: true,),
    )));
  }
}



