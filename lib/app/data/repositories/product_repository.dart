import 'dart:convert';

import 'package:api_call/app/data/http/execeptions.dart';
import 'package:api_call/app/data/http/http_client.dart';
import 'package:api_call/app/data/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
}

class ProductRepository implements IProductRepository {
  final IHttpClient client;

  ProductRepository({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(url: 'https://dummyjson.com/products');

    if (response.statusCode == 200) {
      final List<ProductModel> products = [];

      // String to Map
      final body = jsonDecode(response.body);

      body['products'].map((item) {
        final ProductModel product = ProductModel.fromMap(item);
        products.add(product);
      }).toList();

      return products;
    } else if (response.statusCode == 404) {
      throw NotFoundException('url not found');
    } else {
      throw Exception('Products could not be loaded');
    }
  }
}
