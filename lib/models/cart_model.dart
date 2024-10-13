import 'product_model.dart';

class CartItem {
  Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}

List<CartItem> cartProducts = [];