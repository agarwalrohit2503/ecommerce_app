import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/constants/appColors.dart';
import 'package:ecommerce_application/data/getApis.dart';
import 'package:ecommerce_application/models/product_category.dart';
import 'package:ecommerce_application/models/products.dart';
import 'package:ecommerce_application/screens/user_form.dart';
import 'package:ecommerce_application/widgets/side_menu.dart';
import 'package:ecommerce_application/globals.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _bannerUrl =
      "https://i.pinimg.com/originals/0b/a3/d6/0ba3d60362c7e6d256cfc1f37156bad9.jpg";

  List<ProductModel> _products = [];
  List<ProductCategoryModel> _productCategories = [];

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    _productCategories = await getProductCategoriesAPI();
    productCollection = firestore.collection("products");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().mainColor,
        title: Text("Slice"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserForm(),
                ));
              },
              child: Icon(Icons.shopping_bag_outlined)),
        ],
      ),
      drawer: SideMenu(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDiscover(),
                Container(
                  height: _screenHeight / 5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _productCategories.length,
                    itemBuilder: (context, index) {
                      return _buildCategories(
                          _productCategories.elementAt(index)
                          // _productCategories[index]
                          );
                    },
                  ),
                ),
                Container(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return _buildFilters();
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: productCollection.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data.docs.isEmpty) {
                          return Center(
                            child: Text("No Data Found"),
                          );
                        } else {
                          return ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...snapshot.data.docs.map((e) {
                                ProductModel product = ProductModel.fromJson(e);
                                return _buildProduct(_screenHeight, product);
                              })
                            ],
                          );
                        }
                      }
                    },
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 10,
                //     itemBuilder: (context, index) {
                //       return _buildProduct(_screenHeight);
                //     },
                //   ),
                // ),
              ],
            ),
    );
  }

  _buildDiscover() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Discover",
        textScaleFactor: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildCategories(ProductCategoryModel category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(category.categoryImage),
            radius: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(category.categoryName),
        ],
      ),
    );
  }

  _buildFilters() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      child: Text("Filters"),
    );
  }

  _buildProduct(_screenHeight, ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    // borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              product.price.toString(),
                              textScaleFactor: 0.7,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
