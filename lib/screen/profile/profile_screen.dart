import 'package:flutter/material.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/repository/user_repository.dart';
import 'package:gypsy/response/user_response.dart';
import 'package:gypsy/screen/cart/cart_page.dart';
import 'package:gypsy/screen/favorites/favorites_page.dart';
import 'package:gypsy/screen/login/login_screen.dart';
import 'package:gypsy/screen/map/my_store.dart';
import 'package:gypsy/screen/order/order.dart';
import 'package:gypsy/screen/profile/about.dart';
import 'package:gypsy/screen/profile/change_password.dart';
import 'package:gypsy/screen/profile/update_profile.dart';
import 'package:gypsy/widget/profile_menu_widget.dart';
import 'package:gypsy/widget/snackbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({key});
  static String route = "/profileScreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String imageUnavailable =
      "https://imgs.search.brave.com/Y9KkqbCsxg1wPK4Sf53X3WnUyTSog2jdCjdXBTjayXw/rs:fit:449:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5Y/aWhwbjJMNnQtUTNQ/X1owYVY3Y3JRSGFI/MCZwaWQ9QXBp";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFFFC6011),
          title: const Text("Your Profile",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  //fetching user profile details
                  getUserProfile(),
                  SizedBox(
                    width: 100 * 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateProfileScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 237, 105, 28),
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(height: 5),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyStoreLocation()));
                    },
                    child: const ProfileMenuWidget(
                      title: "Address",
                      iconColor: Color(0XFFFC6011),
                      bgColor: Color(0XFFFC6011),
                      icon: LineAwesomeIcons.map_marker,
                    ),
                  ),

                  //Favourite part in profile screen
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FavoriteScreen()));
                    },
                    child: const ProfileMenuWidget(
                      title: "favorite",
                      bgColor: Color(0XFFFC6011),
                      iconColor: Color(0XFFFC6011),
                      icon: LineAwesomeIcons.heart,
                    ),
                  ),

                  //My cart in profile section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                    },
                    child: const ProfileMenuWidget(
                      title: "My Cart",
                      bgColor: Color(0XFFFC6011),
                      iconColor: Color(0XFFFC6011),
                      icon: LineAwesomeIcons.shopping_cart,
                    ),
                  ),

                  //Order history Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OrderScreen()));
                    },
                    child: const ProfileMenuWidget(
                      title: "Order History",
                      bgColor: Color(0XFFFC6011),
                      iconColor: Color(0XFFFC6011),
                      icon: LineAwesomeIcons.history,
                    ),
                  ),

                  //About us Section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AboutScreen()));
                    },
                    child: const ProfileMenuWidget(
                      title: "About Us",
                      iconColor: Color(0XFFFC6011),
                      bgColor: Color(0XFFFC6011),
                      icon: LineAwesomeIcons.question,
                      endIcon: true,
                    ),
                  ),

                  //Change password section
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ChangePasswordScreen()));
                    },
                    child: const ProfileMenuWidget(
                      title: "Change Password",
                      bgColor: Color(0XFFFC6011),
                      iconColor: Color(0XFFFC6011),
                      icon: LineAwesomeIcons.lock,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),

                  //Logout section
                  GestureDetector(
                    onTap: () async {
                      showLogOutDialog();
                    },
                    child: const ProfileMenuWidget(
                      title: "Logout",
                      bgColor: Colors.red,
                      icon: LineAwesomeIcons.alternate_sign_out,
                      iconColor: Colors.red,
                      // textColor: Colors.red,
                      endIcon: false,
                    ),
                  ),
                ],
              )),
            ),
          ]),
        ));
  }

  FutureBuilder<UserResponse?> getUserProfile() {
    return FutureBuilder<UserResponse?>(
      future: UserRepository().getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? userData = snapshot.data!.data!;
          return Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 30 * 4,
                    height: 40 * 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50 * 2),
                      child: Image.network(
                        userData.userImage!,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50 * 2)),
                      child: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                userData.name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(userData.email!),
              const SizedBox(height: 10),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void showLogOutDialog() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to logout',
      titleColor: Theme.of(context).colorScheme.tertiary,
      // textColor: Colors.red,
      confirmBtnTextStyle: const TextStyle(
        fontFamily: "Satoshi Medium",
        fontSize: 17,
      ),
      cancelBtnTextStyle: TextStyle(
        fontFamily: "Satoshi Medium",
        fontSize: 17,
        // backgroundColor: Colors.red,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      onCancelBtnTap: () {
        Navigator.pop(context);
      },

      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("token", "");
        showSnackbar(context, "Logout Successfully!", Colors.orange);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    );
  }
}
