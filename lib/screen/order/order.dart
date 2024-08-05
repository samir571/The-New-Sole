import 'package:flutter/material.dart';
import 'package:gypsy/screen/order/cancelled_order.dart';
import 'package:gypsy/screen/order/completed_order.dart';
import 'package:gypsy/screen/order/pending_order.dart';

class OrderScreen extends StatefulWidget {
  static const String route = "/OrderScreen";
  const OrderScreen({key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int selectedIndex = 0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _tabController = TabController(length: _tabviewChildren.length, vsync: this)
  //   super.initState();
  // }

  Color setColor(int tabIndex) {
    return selectedIndex == tabIndex
        ? Colors.white
        : Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    TabController? _tabController;

    return DefaultTabController(
      length: 3,
      
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
          centerTitle: true,
          backgroundColor: const Color(0XFFFC6011),
        ),
        body: Column(children: [
          TabBar(
            indicatorColor: Colors.green,
            controller: _tabController,
            onTap: (selectedTab) {
              selectedIndex = selectedTab;
            },
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled")
            ],
          ),
          const Expanded(
            child: TabBarView(children: [
              PendingOrder(),
              Completeorder(),
              CanceledOrder(),
            ]),
          ),
        ]),
      ),
    );
  }
}
