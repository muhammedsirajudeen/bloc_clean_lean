import 'package:bloc_sample_clean/domain/product.dart';

abstract class ProductUseCaseAbstract{
  Future<Product?> fetchProduct();
}
