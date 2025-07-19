import 'package:bloc_sample_clean/domain/product.dart';
import 'package:bloc_sample_clean/presentation/bloc/product_bloc.dart';
import 'package:bloc_sample_clean/presentation/bloc/product_event.dart';
import 'package:bloc_sample_clean/presentation/bloc/product_state.dart';
import 'package:bloc_sample_clean/usecase/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget{
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (_)=>ProductBloc(ProductUseCase())..add(LoadProductEvent()),
      child: Scaffold(
        body: BlocBuilder<ProductBloc,ProductState>(builder:(context, state) {
          if(state is ProductLoading){
            return const Center(child:CircularProgressIndicator());
          }else if(state is ProductLoaded){
            final product=state.product;
            return Row(
              children: [
                Text(product.title),
                Text(product.brand)
              ],
            );
          }else if(state is ProductError){
          return Text("Some kind of error in loading product");
          }else{
            return Text("error occured");
          }
        },),
      )
      );
  }
}