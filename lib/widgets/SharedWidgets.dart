import 'package:fluttertoast/fluttertoast.dart';

///Toast

showToast({String msg="", toastLength}) => Fluttertoast.showToast(
  msg: msg,
  //  toastDuration: Duration(seconds: 2),
  toastLength: toastLength ?? Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 3,
  // backgroundColor: Colors.red,
  // textColor: Colors.white,
  fontSize: 16.0,
);