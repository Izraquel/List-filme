List<ProductModel> productsFromJson(dynamic str) =>
    List<ProductModel>.from((str).map((x) => ProductModel.fromJson(x)));

class ProductModel {
  late String? id;
  late String? productName;
  late String? productImage;
  late int? productPrice;

  ProductModel({
    this.id,
    this.productName,
    this.productImage,
    this.productPrice,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    productName = json["productName"];
    productPrice = json["productPrice"];
    productImage = json["productImage"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data["id"] = id;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productImage"] = productImage;

    return data;
  }
}
