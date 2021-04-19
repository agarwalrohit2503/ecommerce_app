import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String name;
  String image;
  int price;

  ProductModel({
    this.name,
    this.image,
    this.price,
  });

  factory ProductModel.fromJson(QueryDocumentSnapshot data) {
    return ProductModel(
      name: data['name'],
      image: data['image'],
      price: data['price'],
    );
  }
}
