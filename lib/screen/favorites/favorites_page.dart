import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/screen/cart/cart_page.dart';
import 'package:gypsy/screen/home/home_controller.dart';
import 'package:gypsy/screen/home/open_container.dart';
import 'package:gypsy/screen/home/product_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  static const String route = "/favorite_screen";

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FutureBuilder<List<Product>?> getAllFavoriteProduct() {
    return FutureBuilder<List<Product>?>(
      future: UserRepository().getUserWishlistProduct(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<dynamic> productList = snapshot.data!;
          return StaggeredGridView.countBuilder(
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            crossAxisCount: 2,
            crossAxisSpacing: 2, //horizontal spacing
            mainAxisSpacing: 3, //vertical ---- spacing
            itemCount: productList.length,
            itemBuilder: (context, index) {
              // Widget ko meaning --> my creative design

              return OpenContainerWrapper(
                  product: productList[index],
                  child: ProductTile(
                    productList[index],
                  ));
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    getAllFavoriteProduct();
    super.initState();
  }

  @override
  void dispose() {
    getAllFavoriteProduct();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController productController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Favorites"),
        centerTitle: true,
        backgroundColor: const Color(0XFFFC6011),
        
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          // const Padding(
          //   padding: EdgeInsets.only(left: 20),
          //   child: Align(
          //       alignment: Alignment.center,
          //       child: Text("Your Favorite Product",
          //           style: TextStyle(fontSize: 25, color: mainColor))),
          // ),
          const SizedBox(height: 8),
          const SizedBox(height: 10.0),
          Expanded(child: getAllFavoriteProduct()),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CartScreen()));
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Positioned(
                    height: 16,
                    width: 16,
                    child: Lottie.asset(
                      'assets/images/cart.json',
                      width: 70,
                      height: 70,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
