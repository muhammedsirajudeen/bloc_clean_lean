import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample_clean/usecase/user.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent,ProductState>{
  final ProductUseCase _productUseCase;

  ProductBloc(this._productUseCase): super(ProductInitial()){
    on<LoadProductEvent>(_LoadProduct);
  }
  Future<void> _LoadProduct(
    LoadProductEvent event,
    Emitter<ProductState> emit
  ) async{
    emit(ProductLoading());
    try {
      final product=await _productUseCase.fetchProduct();
      if(product==null){
        emit(ProductError("Product not found"));
      }else{
        emit(ProductLoaded(product));
      }

    } catch (e) {
      print("error in fetching product $e");
      emit(ProductError("Something went wrong: ${e.toString()}"));

    }
  }
  
}