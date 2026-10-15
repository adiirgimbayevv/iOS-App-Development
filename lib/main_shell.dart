import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'auth_storage.dart';
import 'detail_screen.dart';
import 'models.dart';
import 'sample_data.dart';

class MainShell extends StatefulWidget {
  final AppUser user;

  const MainShell({super.key, required this.user});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  final Set<String> _favoriteIds = {};

  List<Product> get _favorites =>
      sampleProducts.where((p) => _favoriteIds.contains(p.id)).toList();

  void _toggleFavorite(String id) {
    setState(() {
      if (_favoriteIds.contains(id)) {
        _favoriteIds.remove(id);
      } else {
        _favoriteIds.add(id);
      }
    });
  }

  void _openDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          product: product,
          isFavorite: _favoriteIds.contains(product.id),
          onToggleFavorite: () => _toggleFavorite(product.id),
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      FeedTab(
        products: sampleProducts,
        favoriteIds: _favoriteIds,
        onOpenDetail: _openDetail,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoritesTab(
        favorites: _favorites,
        onOpenDetail: _openDetail,
        onToggleFavorite: _toggleFavorite,
      ),
      ProfileTab(user: widget.user),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
          color: AppColors.surface,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class FeedTab extends StatelessWidget {
  final List<Product> products;
  final Set<String> favoriteIds;
  final void Function(Product) onOpenDetail;
  final void Function(String) onToggleFavorite;

  const FeedTab({
    super.key,
    required this.products,
    required this.favoriteIds,
    required this.onOpenDetail,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sport Nutrition Feed'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          final isFavorite = favoriteIds.contains(product.id);
          return ProductCard(
            product: product,
            isFavorite: isFavorite,
            onTap: () => onOpenDetail(product),
            onToggleFavorite: () => onToggleFavorite(product.id),
          );
        },
      ),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  final List<Product> favorites;
  final void Function(Product) onOpenDetail;
  final void Function(String) onToggleFavorite;

  const FavoritesTab({
    super.key,
    required this.favorites,
    required this.onOpenDetail,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        automaticallyImplyLeading: false,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: AppColors.muted),
                  SizedBox(height: 12),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Tap the heart on a product to save it here.',
                    style: TextStyle(color: AppColors.muted),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ProductCard(
                  product: product,
                  isFavorite: true,
                  onTap: () => onOpenDetail(product),
                  onToggleFavorite: () => onToggleFavorite(product.id),
                );
              },
            ),
    );
  }
}

class ProfileTab extends StatefulWidget {
  final AppUser user;

  const ProfileTab({super.key, required this.user});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? _assistantAnswer;

  static const _faq = <String, String>{
    'How much protein per day?':
        'A common target is 1.6–2.2 g of protein per kg of body weight, depending on training intensity.',
    'When to take creatine?':
        'Anytime daily works. Many people take 5g after training with a meal or shake.',
    'Best beginner stack?':
        'Start with whey protein + creatine. Add pre-workout only if you need extra energy.',
  };

  String get _roleHint {
    switch (widget.user.role) {
      case 'Trainer':
        return 'Trainer space (coming soon): client plans, supplement guides, and coaching tools.';
      case 'Athlete':
        return 'Athlete space (coming soon): training nutrition, macros, and recovery tips.';
      default:
        return 'Customer space (coming soon): shop deals, orders, and recommendations.';
    }
  }

  IconData get _roleIcon {
    switch (widget.user.role) {
      case 'Trainer':
        return Icons.sports;
      case 'Athlete':
        return Icons.emoji_events;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.purple, AppColors.purpleDeep],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.purple.withValues(alpha: 0.45),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.surface,
                    child: Icon(_roleIcon, size: 40, color: AppColors.purpleGlow),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(user.email, style: const TextStyle(color: AppColors.muted)),
                const SizedBox(height: 8),
                Chip(
                  avatar: const Icon(
                    Icons.badge,
                    size: 18,
                    color: AppColors.purpleGlow,
                  ),
                  label: Text(
                    user.role,
                    style: const TextStyle(
                      color: AppColors.purpleGlow,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: AppColors.purple.withValues(alpha: 0.18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Role preview',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _roleHint,
                  style: const TextStyle(color: AppColors.muted, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Nutrition Assistant',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ask a quick question — answers are predefined for now.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _faq.keys.map((question) {
              final selected = _assistantAnswer == _faq[question];
              return ChoiceChip(
                label: Text(question),
                selected: selected,
                onSelected: (_) {
                  setState(() => _assistantAnswer = _faq[question]);
                },
              );
            }).toList(),
          ),
          if (_assistantAnswer != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.surfaceLight,
                border: Border.all(color: AppColors.purple.withValues(alpha: 0.4)),
              ),
              child: Text(
                _assistantAnswer!,
                style: const TextStyle(height: 1.4, color: AppColors.text),
              ),
            ),
          ],
          const SizedBox(height: 24),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.settings, color: AppColors.purpleGlow),
            title: const Text(
              'Account settings',
              style: TextStyle(color: AppColors.text),
            ),
            subtitle: const Text(
              'Notifications, language, privacy',
              style: TextStyle(color: AppColors.muted),
            ),
            trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings screen can be added later.'),
                ),
              );
            },
          ),
          const Divider(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () async {
                await AuthStorage().logout();
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (_) => false,
                );
              },
              icon: const Icon(Icons.logout, color: AppColors.danger),
              label: const Text(
                'Log out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.danger,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.danger),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      elevation: 0,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 88,
                    height: 88,
                    color: AppColors.surfaceLight,
                    child: const Icon(
                      Icons.fitness_center,
                      color: AppColors.purpleGlow,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
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
                      product.category,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${product.price.toStringAsFixed(0)} ₸ · ${product.date}',
                      style: const TextStyle(
                        color: AppColors.purpleGlow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? AppColors.danger : AppColors.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
