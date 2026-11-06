import 'package:flutter/foundation.dart';
import 'models.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  // Список выбранных товаров для экрана корзины
  List<CartItem> get cartProducts => _items.values.toList();

  // Общее количество товаров для live Badge в AppBar
  int get totalCount {
    int count = 0;
    _items.forEach((key, cartItem) {
      count += cartItem.quantity;
    });
    return count;
  }

  // Общая стоимость заказа
  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  // Проверка, добавлен ли товар в корзину
  bool isInCart(String productId) {
    return _items.containsKey(productId);
  }

  // Добавить товар или увеличить количество
  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  // Уменьшить количество или удалить товар
  void removeFromCart(String productId) {
    if (!_items.containsKey(productId)) return;
    
    if (_items[productId]!.quantity > 1) {
      _items[productId]!.quantity -= 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  // Полное удаление конкретной позиции (кнопка мусорки / свайп)
  void removeCompleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  // Очистить всю корзину ("Clear All")
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}