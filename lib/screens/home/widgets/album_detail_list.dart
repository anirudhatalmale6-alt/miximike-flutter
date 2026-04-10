import 'package:flutter/material.dart';
import 'package:flutter_music/api/models/product.dart' as product_model;
import 'package:flutter_music/utils/routes.dart';
import 'package:flutter_music/widgets/products/product.dart';
import 'package:get/get.dart';

class ProductDetailList extends StatelessWidget {
  final String title;
  final String productSubtitle;
  final String titleAllProducts;
  final List<product_model.Product> products;

  const ProductDetailList({
    super.key,
    required this.title,
    required this.productSubtitle,
    required this.titleAllProducts,
    required this.products
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = products.length + (products.length > 1 ? 1 : 0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Vogue Bold'
              ),
            ),
            Text(
              "$itemCount",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Vogue Bold'
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(),
        ),
        GridView.builder(
          itemCount: itemCount,
          padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisExtent: 250,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == products.length) {
              product_model.Product product = product_model.Product(
                  id: 0,
                  name: titleAllProducts,
                  isAll: false,
                  imageUrl: products[index - 1].imageUrl,
                  type: product_model.ProductType.disk,
                  tracks: products.map((e) => e.tracks).expand((element) => element).toList(),
                  categories: [],
              )..setArtist(products[index - 1].artist);

              return Product(
                imageUrl: product.imageUrl,
                title: product.name,
                subTitle: "${product.tracks.length} $productSubtitle",
                onTap: () => Get.toNamed(
                  Routes.productDetails,
                  arguments: {
                    'product': product
                  },
                ),
              );
            }
            return Product(
              imageUrl: products[index].imageUrl,
              title: products[index].name,
              subTitle: "${products[index].tracks.length} $productSubtitle",
              onTap: () => Get.toNamed(
                Routes.productDetails,
                arguments: {
                  'product': products[index]
                },
              ),
            );
          },
        ),
      ],
    );
  }
}