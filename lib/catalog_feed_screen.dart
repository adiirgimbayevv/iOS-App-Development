import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'cart_provider.dart';
import 'models.dart';

class CatalogFeedScreen extends StatelessWidget {
  final List<Product> products;
  final VoidCallback onOpenCart; // Переход на Экран 2 (Корзина)
  final void Function(Product) onOpenDetail; // Открытие детального просмотра
  final void Function(String) onToggleFavorite; // Переключение избранного
  final Set<String> favoriteIds; // Список ID избранных товаров

  const CatalogFeedScreen({
    super.key,
    required this.products,
    required this.onOpenCart,
    required this.onOpenDetail,
    required this.onToggleFavorite,
    required this.favoriteIds,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        automaticallyImplyLeading: false,
        actions: [
          // Кнопка корзины с Live Badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 26),
                onPressed: onOpenCart,
              ),
              if (cartProvider.totalCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${cartProvider.totalCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          final isInCart = cartProvider.isInCart(product.id);
          final cartItem = cartProvider.items[product.id];
          final quantity = cartItem?.quantity ?? 0;
          final isFavorite = favoriteIds.contains(product.id);

          return Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Клик по картинке/карточке теперь открывает DetailScreen
                InkWell(
                  onTap: () => onOpenDetail(product),
                  borderRadius: BorderRadius.circular(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl,
                      width: 76,
                      height: 76,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 76,
                        height: 76,
                        color: AppColors.surfaceLight,
                        child: const Icon(Icons.fitness_center, color: AppColors.purpleGlow),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onOpenDetail(product),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product.price.toStringAsFixed(0)} ₸',
                          style: const TextStyle(
                            color: AppColors.purpleGlow,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Кнопка Избранного (Сердечко)
                IconButton(
                  onPressed: () => onToggleFavorite(product.id),
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.danger : AppColors.muted,
                  ),
                ),
                const SizedBox(width: 4),
                // Интерактивная кнопка Add to Cart / Счётчик +/-
                isInCart
                    ? Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: AppColors.muted),
                            onPressed: () => cartProvider.removeFromCart(product.id),
                          ),
                          Text(
                            '$quantity',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.text,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: AppColors.purpleGlow),
                            onPressed: () => cartProvider.addToCart(product),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          backgroundColor: AppColors.purpleDeep,
                        ),
                        onPressed: () => cartProvider.addToCart(product),
                        child: const Text('Add to Cart'),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}