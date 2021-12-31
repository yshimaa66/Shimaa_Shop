import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onmarket_task/main.dart';
import 'package:onmarket_task/models/Order.dart';
import 'package:onmarket_task/models/Product.dart';
import 'dart:ui' as ui;
import 'package:onmarket_task/modules/appcubit/states.dart';
import 'package:onmarket_task/widgets/SharedWidgets.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(Initial());

  static AppCubit get(context) => BlocProvider.of(context);

  Cart currentCart = new Cart();

  bool isLoading = false;

  static int orderId = 0;
  late Order lastOrder;

  late Order oldOrder;

  void addOrderToCart(Product product, int quantity){
    lastOrder = new Order(product, quantity, orderId++);
    if(checkIfOrderExist(product)){
      currentCart.editOrder(oldOrder,lastOrder);
    }else{
      currentCart.addOrder(lastOrder);
    }
    showToast(msg: "Order added to cart");
    emit(AddToCart());
  }

  bool checkIfOrderExist(Product product){

    for(Order order in currentCart.orders){
      if(order.product.id == product.id){
        oldOrder = order;
        return true;
      }
    }
    return false;
  }

  int getOrderQuantityInCart(Product product) {
     for (Order order in currentCart.orders) {
       if (order.product.id == product.id) {
         return order.quantity;
       }
     }
     return 0;
   }

  void removerOrderOfCart(Order order){
    currentCart.removeOrder(order);
    showToast(msg: "Order removed from cart");
    emit(RemoveFromCart());
  }

  void emptyCart(){
    currentCart.emptyCart();
    showToast(msg: "Cart is empty");
    emit(EmptyCart());
  }

  toggleIsLoading() {
    isLoading = !isLoading;
    emit(IsLoading());
  }

}


class Cart{

  List<Order> orders = [];

  void addOrder(Order order){
    orders.add(order);
  }

  void editOrder(Order oldOrder,Order newOrder){
    int oldOrderIndex = orders.indexOf(oldOrder);
    Order modifiedNewOrder = new Order(newOrder.product,
        newOrder.quantity, newOrder.id);
    orders.remove(oldOrder);
    orders.insert(oldOrderIndex, modifiedNewOrder);
  }

  void removeOrder(Order order){
    orders.remove(order);
  }

  double totalPrice(){
    double total = 0;
    orders.forEach((o){
      total += o.orderPrice;
    });

    return total;
  }

  void emptyCart(){
    orders.clear();
  }

  int get orderCount => orders.length;

  bool get isEmpty => orders.length == 0;

}