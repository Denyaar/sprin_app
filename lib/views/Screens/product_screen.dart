import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procductandroid/Providers/product_provider.dart';
import 'package:procductandroid/common/constants.dart';
import 'package:procductandroid/views/widgets/elev_button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../widgets/product_container.dart';
import '../widgets/product_drawer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sortBy = ['Price Ascending', 'Price Descending', 'none'];

  SortTypes? sortTypes;
  String? sortValue;
  String? searchValue;
  int pagesNumb = 0;
  int nextPage = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<ProductProvider>(context, listen: false)
          .getProducts(0, null, null, GetTypes.PAGING);
      pagesNumb = Provider.of(context, listen: false).pagesNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Products ',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                ElevButton(
                    text: 'Add Product',
                    icon: Icons.add,
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .productToEdit = null;
                      _scaffoldKey.currentState!.openEndDrawer();
                    })
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 180,
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintText: "search by name...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (input) {
                      searchValue = input;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: DropdownButton(
                    hint: const Text('Sort By'),
                    value: sortValue,
                    items: sortBy.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      sortValue = value as String?;
                      if (value == sortBy[0]) {
                        sortTypes = SortTypes.ASC;
                      } else if (value == sortBy[1]) {
                        sortTypes = SortTypes.DESC;
                      } else {
                        sortTypes = null;
                      }
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 15),
                ElevButton(
                    text: 'filter',
                    icon: Icons.filter_list,
                    color: Colors.black,
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .getProducts(
                              0, searchValue, sortTypes, GetTypes.FILTER);
                      pagesNumb =
                          Provider.of(context, listen: false).pagesNumber;
                      nextPage;
                      setState(() {});
                    }),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ResponsiveGridList(
              desiredItemWidth: 200,
              minSpacing: 20,
              children: Provider.of<ProductProvider>(context)
                  .products
                  .map<Widget>((product) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .productToEdit = product;
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: ProductContainer(product: product),
                );
              }).toList()
                ..add(
                  pagesNumb > 1
                      ? SizedBox(
                          height: 210,
                          child: ElevButton(
                            text: 'Load More',
                            icon: Icons.add,
                            color: Colors.grey,
                            onPressed: () async{
                             await Provider.of<ProductProvider>(context,
                                      listen: false)
                                  .getProducts(nextPage, searchValue, sortTypes,
                                      GetTypes.PAGING);
                              pagesNumb--;
                              nextPage++;
                            },
                          ),
                        )
                      : SizedBox(),
                ),
            ),
          )
        ],
      ),
    );
  }
}
