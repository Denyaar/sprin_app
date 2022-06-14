import 'package:flutter/material.dart';
import 'package:procductandroid/Providers/product_provider.dart';
import 'package:procductandroid/views/Screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context)=>ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      home:  ProductScreen(),
      ),
    );
  }
}


