import 'package:flutter/material.dart';
import 'package:onmarket_task/widgets/ProductWidget.dart';
import 'package:onmarket_task/models/Product.dart';
import 'package:onmarket_task/repositories/ProductsRepository.dart';

class GridShop extends StatefulWidget {
  const GridShop({Key? key}) : super(key: key);

  @override
  _GridShopState createState() => _GridShopState();
}

class _GridShopState extends State<GridShop> with TickerProviderStateMixin{

  late TabController _tabController;

  late List<Product> _products;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this);
    _products = new ProductsRepository().fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    double _gridSize = MediaQuery.of(context).size.height*0.88; //88% of screen
    double childAspectRatio =  2/4;


    _body(int productLength){
      return new Container(height: _gridSize - 60, margin: EdgeInsets.only(top: 0), child:
      new PhysicalModel(
          color: Colors.transparent,
          borderRadius:  BorderRadius.only(bottomLeft:
          Radius.circular(_gridSize/10 - 10),
              bottomRight: Radius.circular(_gridSize/10 - 10)),
          clipBehavior: Clip.antiAlias,
          child: new GridView.builder(
              itemCount: productLength,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  childAspectRatio: childAspectRatio),
              itemBuilder: (BuildContext context, int index) {
                return new Padding(
                    padding: EdgeInsets.only(top: index%2==0 ? 20 : 0,
                        right: index%2==0 ? 5 : 0, left: index%2==1 ? 5 : 0,
                        bottom: index%2==1 ? 20 : 0),
                    child: ProductWidget(product: _products[index]));
              }
          )
      )
      );
    }


    return new Column(children: <Widget>[
      new Container(height: _gridSize,
          decoration: BoxDecoration(color: const Color(0xFFeeeeee),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(_gridSize/10),
                  bottomRight: Radius.circular(_gridSize/10))),
          padding: EdgeInsets.only(left: 10, right: 10,top: height/15), child:
          new Column(children: <Widget>[
            Container(
              child: new TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color:Colors.black,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    CategoryTab(tabText:"Top Rated"),
                    CategoryTab(tabText:"Most Selling"),
                    CategoryTab(tabText: "Recently Viewed",),
                  ]),
            ),
              Flexible(
              fit: FlexFit.tight,
              child: TabBarView(
                  children: [
                    _body(_products.length),
                    _body(3), _body(1)
                  ],
                  controller: _tabController,
                ),),

          ])
      ),
      //new MinimalCart(_gridSize)
    ]);
  }
}

class CategoryTab extends StatelessWidget {

  final String tabText;

  const CategoryTab({Key? key,required this.tabText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.black, width: 1)),
        child: Align(
          alignment: Alignment.center,
          child: Text(tabText,textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
