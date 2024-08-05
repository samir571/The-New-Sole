// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gypsy/constraints/constraints.dart';
import 'package:gypsy/constraints/responsive.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/model/product_category.dart';
import 'package:gypsy/repository/product_category_repository.dart';
import 'package:gypsy/repository/product_repository.dart';
import 'package:gypsy/response/product_category_response.dart';
import 'package:gypsy/response/product_response.dart'; 
import 'package:gypsy/screen/cart/cart_page.dart';
import 'package:gypsy/screen/category/category_screen.dart';
// import 'package:getx_app/routes/app_routes.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; //Obx
// import 'package:get/instance_manager.dart';
// import 'package:shopx/controllers/productcontroller.dart';

import 'package:gypsy/screen/home/color_data.dart';
import 'package:gypsy/screen/home/home_controller.dart';
import 'package:gypsy/screen/home/open_container.dart';
import 'package:gypsy/screen/home/product_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({key});
  static String route = "/HomeScreen";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController productController = Get.put(HomeController());
  bool isInWishList = false;

  String imageUrl =
      "https://assets-api.kathmandupost.com/thumb.php?src=https://assets-cdn.kathmandupost.com/uploads/source/news/2022/opinion/shutterstock1358850531-1642092669.jpg&w=900&height=601";
  List<Product> originalProductList = [];
  List<Product> searchedProductList = [];

  FutureBuilder<ProductResponse?> getAllProduct() {
    return FutureBuilder<ProductResponse?>(
      future: ProductRepository().getAllProduct(),
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
            crossAxisSpacing: 0, //horizontal spacing
            mainAxisSpacing: 0, //vertical ---- spacing
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

          // return GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 0.65,
          //       crossAxisSpacing: 0,
          //       mainAxisSpacing: 0),
          //   itemCount: searchedProductList.length,
          //   itemBuilder: (context, index) {
          //     // Widget ko meaning --> my creative design
          //     return OpenContainerWrapper(
          //         product: searchedProductList[index],
          //         child: ProductTile(
          //           searchedProductList[index],
          //         ));
          //   },
          // );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void initState() {
    getAllProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      //-----------------------------Home page app bar---------------------------------------
      appBar: AppBar(
          title: const Text("The New Sole"),
          centerTitle: true,
          backgroundColor: const Color(0XFFFC6011),
          //----------------------------------CART ICON AT APP BAR--------------------------------
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CartScreen.route);
                },
                child: LottieBuilder.asset(
                  "assets/images/carticon.json",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ]),

      //----------------------------- END OF HOME PAGE APP BAR-(------------------------------

      //------------------------------BODY SECTION OF HOME PAGE-)-----------------------------
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 180,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    // shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: AppData.recommendedProducts.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 375,
                          decoration: BoxDecoration(
                            color: AppData
                                .recommendedProducts[index].cardBackgroundColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Big Saving Upto \n 30% off',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppData
                                            .recommendedProducts[index]
                                            .buttonBackgroundColor,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                      ),
                                      child: Text(
                                        "Buy Now",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppData
                                                .recommendedProducts[index]
                                                .buttonTextColor!),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/images/shopping.png',
                                height: 125,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 10),

              //----------------------------Product Category---------------------

              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Categories",
                        style: TextStyle(fontSize: 22, color: Colors.black))),
              ),
              const SizedBox(
                height: 5,
              ),

              getMyCategory(),

              //-----------------------------------------------------------------------------------------
              const SizedBox(
                height: 20,
              ),

              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("New Sole Collections",
                        style: TextStyle(fontSize: 22, color: Colors.black87))),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 10.0),

              Expanded(child: getAllProduct()),

              /*
              Expanded(
                child: Obx(() {
                  if (productController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container();
                  }
                }),
              )
              */
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<ProductCategoryResponse?> getMyCategory() {
    return FutureBuilder(
        future: ProductCategoryRepository().getAllProductCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductCategory>? categoryList = snapshot.data!.data!;
            print("The Category: -->${categoryList[0]}");
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Row(
                    children: [
                      for (int index = 0; index < categoryList.length; index++)
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                      recievedCategoryId:
                                          categoryList[index].id!,
                                      recievedCategoryName:
                                          categoryList[index].categoryName))),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                              categoryList[index]
                                                      .categoryImageURL
                                                      .isNotEmpty
                                                  ? categoryList[index]
                                                      .categoryImageURL
                                                  : imageUnavailable))),
                                ),
                              ),
                              Positioned(
                                  // top: 95,
                                  bottom: 0,
                                  left: 5,
                                  right: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 1, top: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            categoryList[index].categoryName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
