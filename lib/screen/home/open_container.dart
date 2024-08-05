import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gypsy/model/product.dart';

import 'package:gypsy/screen/home/product_detail_page.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper(
      {Key? key, required this.child, required this.product})
      : super(key: key);

  final Widget child;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: OpenContainer(
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        // closedColor: const Color(0xFFE5E6E8),
        // transitionType: ContainerTransitionType.fade,

        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 900),
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return InkWell(
            onTap: openContainer,
            child: child,
          );
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return ProductDetailScreen(product);
        },
      ),
    );
  }
}
