

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procductandroid/Providers/product_provider.dart';
import 'package:procductandroid/common/constants.dart';
import 'package:provider/provider.dart';

import '../widgets/product_drawer.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sortBy = ['Price Ascending','Price Descending','none'];

  SortTypes? sortTypes;
  String? sortValue;
  String? searchValue;
  int pagesNumb=0;
  int nextPage=1;


  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero,() async{
      await Provider.of<ProductProvider>(context,listen: false)
          .getProducts(0, null, null, GetTypes.PAGING); 
      pagesNumb =
          Provider.of(context,listen: false).pagesNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
            'Ecommerce Admin Panel',
            style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: const [SizedBox()],
      ),
      endDrawer: const AddProductDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
