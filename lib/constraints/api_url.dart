//--> only for your local server
// const baseUrl = "http://localhost:3000/";

// --> only for your android (localhost --> 10.0.2.2)
import 'package:gypsy/model/product.dart';

const baseUrl = "http://10.0.2.2:3000/api/";
// const baseUrl = "http://192.168.1.75:3000/api/";
// const baseUrl = "http://172.26.1.220:3000/api/";

// other urls
const loginUrl = "signin";
const registerUrl = "signup";
const categoryUrl = "product";
const userUrl = "user";
const changePasswordUrl = "user/change-password";
const cartUrl = "cart";
const orderUrl = "order";

const updateProfileAllUrl = "user/update/profile-all";
const updateProfileDataUrl = "user/update/profile-data";
const productUrl = "product/all-product";
const productWishlistUrl = "user/wishlistProduct";
const favoriteProductUrl = "product/wish-product";
const productCategoryUrl = "category/all-category";

String UID = "";
String TOKEN = "";

// for token
String? tokenConstant;
String? loggedInUserId;
List<Product>? loggedInUserWishlist;
