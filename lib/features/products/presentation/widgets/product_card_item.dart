import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

class ProductCardItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCardItem({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),

      elevation: 2,

      child: InkWell(
        onTap: onTap,

        borderRadius:
        BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(10),

                child: CachedNetworkImage(
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
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [
                    Text(
                      product.title,

                      maxLines: 1,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style:
                      const TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      product.description,

                      maxLines: 2,

                      overflow:
                      TextOverflow
                          .ellipsis,

                      style: TextStyle(
                        color: Colors
                            .grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                      children: [
                        Text(
                          '₹ ${product.price}',

                          style:
                          const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        Flexible(
                          child: Chip(
                            label: Text(
                              product.category,

                              overflow:
                              TextOverflow
                                  .ellipsis,
                            ),
                          ),
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
  }
}