import 'package:api_call/app/data/http/execeptions.dart';
import 'package:api_call/app/data/models/product_model.dart';
import 'package:api_call/app/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductStore {
  final IProductRepository repository;

  ProductStore({required this.repository});

  // reactive variable for loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // reactive variable for state
  final ValueNotifier<List<ProductModel>> state =
      ValueNotifier<List<ProductModel>>([]);

  // reactive variable for error
  final ValueNotifier<String> error = ValueNotifier<String>('');

  Future getProducts() async {
    isLoading.value = true;
    repository?.getProducts();

    try {
      final result = await repository?.getProducts();
      state.value = result!;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
