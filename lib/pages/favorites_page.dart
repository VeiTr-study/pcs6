import 'package:flutter/material.dart';
import 'product_detail_page.dart';
import '../models/favorites_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favoritesProducts.isEmpty
          ? const Center(
        child: Text('Нет избранных товаров'),
      )
          : ListView.builder(
        itemCount: favoritesProducts.length,
        itemBuilder: (context, index) {
          final product = favoritesProducts[index];
          return ListTile(
            leading: product.isImageUrl()
                ? Image.network(product.image, fit: BoxFit.cover)
                : Image.asset(product.image, fit: BoxFit.cover),
            title: Text(product.name),
            subtitle: Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                setState(() {
                  favoritesProducts.remove(product);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          '${product.name} удален из избранного')),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailPage(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}