import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product.thumbnail,

              width: 90,
              height: 90,

              fit: BoxFit.cover,

              placeholder:
                  (context, url) {
                return Container(
                  width: 90,
                  height: 90,
                  alignment:
                  Alignment.center,
                  child:
                  const CircularProgressIndicator(),
                );
              },

              errorWidget:
                  (
                  context,
                  url,
                  error,
                  ) {
                return Container(
                  width: 90,
                  height: 90,

                  alignment:
                  Alignment.center,

                  color:
                  Colors.grey.shade200,

                  child: const Icon(
                    Icons
                        .image_not_supported,
                    size: 30,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(product.description),
                  const SizedBox(height: 12),
                  Text(
                    '₹ ${product.price}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Chip(label: Text(product.category)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}