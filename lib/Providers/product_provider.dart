import 'package:flutter/cupertino.dart';
import 'package:procductandroid/Repositories/product_repository.dart';
import 'package:procductandroid/common/constants.dart';
import 'package:procductandroid/models/product.dart';

class ProductProvider extends ChangeNotifier{
  List<Product> products = [];
  Product? productToEdit;
  int pagesNumber = 0;

  final ProductRepository _productRepository =ProductRepository();

  getProducts(int page, String? searchValue, SortTypes? sortType, GetTypes? getType)async{

    Map<String,dynamic> returnedData = await _productRepository.getProductsList(page, searchValue, sortType);
    List<Product> pageProducts = returnedData["products list"];
    pagesNumber = returnedData["pagesnumber"];

  }

}