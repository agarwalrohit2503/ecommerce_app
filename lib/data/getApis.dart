import 'dart:convert';

import 'package:ecommerce_application/models/product_category.dart';
import 'package:http/http.dart' as http;

Future<List<ProductCategoryModel>> getProductCategoriesAPI() async {
  String url = "https://ranjeetbihare.in/test/index.php?data=getCategories";
  http.Response res = await http.get(Uri.parse(url));
  List response = json.decode(res.body);
  List<ProductCategoryModel> productCategories =
      new List.from(response.map((e) => ProductCategoryModel.fromJson(e)));
  return productCategories;
}
