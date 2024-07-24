import 'package:flutter/cupertino.dart';
import 'package:sushi_app_jhonny_mustafa/models/cart_model.dart';
import 'package:sushi_app_jhonny_mustafa/models/food.dart';

class Cart extends ChangeNotifier {
  final List<CartModel> _cart = [];

  List<CartModel> get cart => _cart;

  void addToCart(Food food, int qty) {
    _cart.add(
      CartModel(
        name: food.name,
        price: food.price,
        imagePath: food.imagePath,
        quantity: qty.toString(),
      ),
    );
    notifyListeners();
  }

  void removeFoodCart(CartModel item) {
    _cart.remove(item);
    notifyListeners();
  }
}
