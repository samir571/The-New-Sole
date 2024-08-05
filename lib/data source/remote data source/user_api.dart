import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/constraints/http_services.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/response/login_response.dart';
import 'package:gypsy/response/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    bool isRegister = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response

      Response response = await dio.post(registerUrl, data: user.toJson());
      if (response.statusCode == 200) {
        isRegister = true;
        return isRegister;
      }
    } catch (exception) {
      print(exception);
    }
    return isRegister;
  }

  Future<bool> loginUser(String email, String password) async {
    bool isLogin = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      Map<String, dynamic> userLoginData = {
        "email": email,
        "password": password
      };
      // dio ko response --> server le dine
      Response response = await dio.post(loginUrl, data: userLoginData);
      // response.data
      final LoginResponse loginResponseKoData =
          LoginResponse.fromJson(response.data);
      tokenConstant = loginResponseKoData.token;
      if (response.statusCode == 200) {
        TOKEN = "Bearer ${loginResponseKoData.token!}";
        final pref = await SharedPreferences.getInstance();
        pref.setString("token", tokenConstant!);
        pref.setBool("isUninstall", false);
        isLogin = true;
        return isLogin;
      }
    } catch (exception) {
      print(exception);
    }
    return isLogin;
  }

  Future<bool> addToWishlist(String productId) async {
    bool isAdded = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.post("$productWishlistUrl/$productId",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      if (response.statusCode == 200) {
        isAdded = true;
        return isAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isAdded;
  }

  Future<List<Product>?> getUserWishlistProduct() async {
    Dio dio = HttpServices().getDioInstance();
    List<Product> productList;
    try {
      // dio ko response --> server le dine
      Response response = await dio.get(productWishlistUrl,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data

      final parsed = response.data["data"];
      print("The product List is:$parsed");

      List<Product> productList =
          List<Product>.from(parsed.map((i) => Product.fromJson(i))).toList();
      loggedInUserWishlist = productList;
      print("The product List is:$productList");

      // userResponse = WishlistResponse.fromJson(myResponseData);

      return productList;
    } catch (exception) {
      print(exception);
    }
    return null;
  }

  // Get single User
  Future<UserResponse?> getUserProfile() async {
    UserResponse? userProfileResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$userUrl/singleProfile",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      userProfileResponse = UserResponse.fromJson(response.data);
      if (userProfileResponse.success == true) {
        return userProfileResponse;
      } else {
        userProfileResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return userProfileResponse;
  }

  Future<bool> updateUserProfileWithImage(User user, File imageFile) async {
    try {
      Dio dio = HttpServices().getDioInstance();
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'name': user.name,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'address': user.address,
        "userImage":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });
      print("The Form Data -->$imageFile");

      Response response = await dio.put(
        updateProfileAllUrl,
        data: formData,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",

            // "Authorization": tokenConstant,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserProfile(User user) async {
    try {
      Dio dio = HttpServices().getDioInstance();

      FormData formData = FormData.fromMap({
        'name': user.name,
        'phoneNumber': user.phoneNumber,
        'email': user.email,
        'address': user.address,
      });

      Response response = await dio.put(
        updateProfileDataUrl,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      Dio dio = HttpServices().getDioInstance();

      FormData formData = FormData.fromMap({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });

      Response response = await dio.post(
        changePasswordUrl,
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
