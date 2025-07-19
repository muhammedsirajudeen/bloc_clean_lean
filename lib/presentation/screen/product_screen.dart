import 'package:bloc_sample_clean/presentation/bloc/product_bloc.dart';
import 'package:bloc_sample_clean/presentation/bloc/product_event.dart';
import 'package:bloc_sample_clean/presentation/bloc/product_state.dart';
import 'package:bloc_sample_clean/usecase/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(ProductUseCase())..add(LoadProductEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "The title is ${product.title}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          product.brand,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Add more product details here if needed
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is ProductError) {
              return const Center(
                child: Text(
                  "Failed to load product.",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            } else {
              return const Center(child: Text("Unexpected state"));
            }
          },
        ),
      ),
    );
  }
}
