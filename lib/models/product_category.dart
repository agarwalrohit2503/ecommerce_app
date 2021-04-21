class ProductCategoryModel {
  String categoryName;
  String categoryImage;
  int categoryId;

  ProductCategoryModel({
    this.categoryName,
    this.categoryImage,
    this.categoryId,
  });

  factory ProductCategoryModel.fromJson(Map data) {
    return ProductCategoryModel(
      categoryName: data['category_name'] ?? "",
      categoryImage: data['category_image'],
      categoryId: int.parse(data['category_id']),
    );
  }
}
