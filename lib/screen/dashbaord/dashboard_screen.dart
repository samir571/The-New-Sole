import 'package:flutter/material.dart';
import 'package:gypsy/screen/favorites/favorites_page.dart';
import 'package:gypsy/screen/home/home_page.dart';
import 'package:gypsy/screen/products/products_screen.dart';
import 'package:gypsy/screen/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({key});
  static const String route = "/dashboard_screen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    const HomePage(),
    const ProductScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Product'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          backgroundColor: const Color.fromARGB(255, 232, 228, 228),
          selectedItemColor: const Color.fromARGB(255, 233, 75, 13),
          unselectedItemColor: const Color.fromARGB(255, 81, 77, 77),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
