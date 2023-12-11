
class Products{
  final String productId;
  final String productName;
  String? productDescription;
  final num productPrice;
  final int productQuantity;
  final String productImage;

  Products({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.productImage});

  Products.productDetails({
    required this.productId,
    required this.productName,
    this.productDescription,
    required this.productPrice,
    required this.productQuantity,
    required this.productImage});
}

