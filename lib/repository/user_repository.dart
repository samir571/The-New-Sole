import 'dart:io';

import 'package:gypsy/data%20source/remote%20data%20source/user_api.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/model/user.dart';
import 'package:gypsy/response/user_response.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }

  Future<bool> loginUser(String phoneNumber, String password) async {
    return await UserAPI().loginUser(phoneNumber, password);
  }

  Future<bool> updateUserProfile(User user) async {
    return await UserAPI().updateUserProfile(user);
  }

  Future<bool> updateUserProfileWithImage(User user, File imageFile) async {
    return await UserAPI().updateUserProfileWithImage(user, imageFile);
  }

  Future<List<Product>?> getUserWishlistProduct() async {
    return await UserAPI().getUserWishlistProduct();
  }

  Future<bool> addToWishlist(String productId) async {
    return await UserAPI().addToWishlist(productId);
  }

  Future<UserResponse?> getUserProfile() async {
    return await UserAPI().getUserProfile();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    return await UserAPI().changePassword(oldPassword, newPassword);
  }
}
