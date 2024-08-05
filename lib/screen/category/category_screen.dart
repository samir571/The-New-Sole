import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/repository/product_repository.dart';
import 'package:gypsy/response/product_response.dart';
import 'package:gypsy/screen/home/open_container.dart';
import 'package:gypsy/screen/home/product_tile.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CategoryScreen extends StatefulWidget {
  final String recievedCategoryId;
  final String recievedCategoryName;

  const CategoryScreen(
      {required this.recievedCategoryId,
      key,
      required this.recievedCategoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categoryId = "";

  @override
  void initState() {
    categoryId = widget.recievedCategoryId;
    print("The recieved category Id:-->$categoryId");
    super.initState();
  }

  String imageUrl =
      "https://assets-api.kathmandupost.com/thumb.php?src=https://assets-cdn.kathmandupost.com/uploads/source/news/2022/opinion/shutterstock1358850531-1642092669.jpg&w=900&height=601";
  List<Product> originalProductList = [];
  List<Product> searchedProductList = [];
  final TextEditingController _searchController = TextEditingController();

  void _searchProduct(String searchTypedText) {
    List<Product> searchResultFound = [];
    if (searchTypedText.isNotEmpty) {
      searchResultFound = originalProductList.where((product) {
        String productNameInSmallCase = product.productName.toLowerCase();
        String searchTypedTextInSmallCase = searchTypedText.toLowerCase();
        return productNameInSmallCase.contains(searchTypedTextInSmallCase);
      }).toList();
    } else {
      searchResultFound = originalProductList;
      print("The all data is:-->$searchResultFound");
    }
    setState(() {
      searchedProductList = searchResultFound;
    });
  }

  FutureBuilder<ProductResponse?> getAllCategoryProduct(String categoryId) {
    return FutureBuilder<ProductResponse?>(
      future: ProductRepository().getAllCategoryProduct(categoryId),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data!.isNotEmpty) {
          List<Product>? productList = snapshot.data!.data;
          originalProductList = productList!;
          if (searchedProductList.isEmpty) {
            searchedProductList = productList;
          }
          print("The search product list: ${searchedProductList.length}");
          return StaggeredGridView.countBuilder(
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            crossAxisCount: 2,
            crossAxisSpacing: 3, //horizontal spacing
            mainAxisSpacing: 3, //vertical ---- spacing
            itemCount: searchedProductList.length,
            itemBuilder: (context, index) {
              // Widget ko meaning --> my creative design
              return OpenContainerWrapper(
                  product: searchedProductList[index],
                  child: ProductTile(
                    searchedProductList[index],
                  ));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recievedCategoryName),
        centerTitle: true,
        backgroundColor: const Color(0XFFFC6011),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 10.0),
          FadeInUp(
            delay: const Duration(milliseconds: 50),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Center(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (newTypedValueInSearchBox) {
                      _searchProduct(newTypedValueInSearchBox);
                    },
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            _searchController.clear();
                            _searchProduct("");
                            // itemsOnSearch = mainList;
                          });
                        },
                        icon: const Icon(Icons.close_sharp),
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 100, 88, 88),
                              ),
                      hintText: "Search for ${widget.recievedCategoryName}",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(child: getAllCategoryProduct(categoryId)),
        ],
      )),
    );
  }
}
