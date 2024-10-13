import 'package:flutter/material.dart';
import 'package:market_place_flutter_e/pages/add_product_page.dart';
import 'product_detail_page.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/favorites_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isInCart = cartProducts.any((item) => item.product.id == product.id);
          final isInFavorites = favoritesProducts.contains(product);
          final cartItem = cartProducts.firstWhere((item) => item.product.id == product.id, orElse: () => CartItem(product, 0));

          return Dismissible(
            key: Key(product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                products.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} удален из каталога')),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: product.isImageUrl()
                          ? Image.network(product.image, fit: BoxFit.cover)
                          : Image.asset(product.image, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${product.price} руб.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    if (isInCart) {
                                      cartProducts[cartProducts.indexWhere((item) => item.product.id == product.id)].quantity++;
                                    } else {
                                      cartProducts.add(CartItem(product, 1));
                                    }
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} добавлено в корзину',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.shopping_cart,
                                  color: isInCart ? Colors.green : Colors.grey,
                                ),
                                label: Text(cartItem.quantity > 0 ? '${cartItem.quantity}' : ''),
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite,
                                    color: isInFavorites
                                        ? Colors.red
                                        : Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    if (isInFavorites) {
                                      favoritesProducts.remove(product);
                                    } else {
                                      favoritesProducts.add(product);
                                    }
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '${product.name} ${isInFavorites ? 'удалено из избранного' : 'добавлено в избранное'}')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}