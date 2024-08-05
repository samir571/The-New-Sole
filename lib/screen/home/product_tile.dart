import 'package:flutter/material.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/repository/product_repository.dart';
import 'package:gypsy/repository/user_repository.dart';

class ProductTile extends StatefulWidget {
  final Product product;

  const ProductTile(this.product, {key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final _productRepo = ProductRepository();
  bool isFromHomePage = false;

  Future<bool> addToWishlist(String productId) async {
    final isAdded = await UserRepository().addToWishlist(productId);
    return isAdded;
  }

  @override
  void initState() {
    for (Product p1 in loggedInUserWishlist!) {
      if (p1.productId == widget.product.productId) {
        isFromHomePage = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 95,
                constraints: const BoxConstraints(maxWidth: double.infinity),
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 1))
                    ]),
                child: Image.network(
                  widget.product.productImageUrlList[0],
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    color: Colors.red,
                    icon: isFromHomePage == true
                        ? const Icon(Icons.favorite_rounded)
                        : const Icon(Icons.favorite_border),
                    onPressed: () async {
                      if (isFromHomePage) {
                        isFromHomePage = false;
                        bool data =
                            await addToWishlist(widget.product.productId);
                        if (data == true) {
                          print(
                              "${widget.product.productName} removed from fav");
                        }
                      } else {
                        isFromHomePage = true;
                        bool data =
                            await addToWishlist(widget.product.productId);
                        if (data == true) {
                          print(
                              "${widget.product.productName} Added to favorite");
                        }
                      }
                      setState(() {});
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 25),
          Text(
            widget.product.productName,
            maxLines: 1,
            style: const TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              // if (5 != null)
              // if (product.rating != null)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Text('Rs.${widget.product.productPrice}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'avenir',
                              fontWeight: FontWeight.w800,
                              color: Colors.black)),
                    ),
                    const SizedBox(width: 50),
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.yellow,
                    ),
                    const Text(
                      "4.5",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
