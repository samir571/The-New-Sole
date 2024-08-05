import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gypsy/constraints/api_url.dart';
import 'package:gypsy/constraints/http_services.dart';
import 'package:gypsy/model/product.dart';
import 'package:gypsy/response/product_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProductAPI {
  Future<bool> addProduct(File? file, Product product) async {
    bool isProductAdded = false;
    Dio dio = HttpServices().getDioInstance();
    MultipartFile? productFinalImageFile;
    if (file != null) {
      var filePath = file.path;

      // it is used to check only for images like: jpg, png, jpeg
      // if we won't check then, user may upload other file type such as: pdf, docx.
      // so, mimeType is used to check for the extension or file type of uploaded file;
      var mimeType = lookupMimeType(filePath);

      // image path: -->I:\final_api\images\
      // file name: --> chat.png
      // absolute path: --> image path + file name
      // absolute path:--> I:\final_api\images\chat.png
      var image = await MultipartFile.fromFile(filePath,
          filename: filePath.split("/").last,
          contentType: MediaType("image", mimeType!.split("/").last));
      productFinalImageFile = image;
    }
    try {
      // dio ko response
      Map<String, dynamic> productMap = {
        "productName": product.productName,
        "productDescription": product.productDescription,
        "productFinalImageFile": productFinalImageFile,
        "productPrice": product.productPrice,
        // "categoryName": product.productCategory,
        "productOffer": product.productOffer,
        "productQuantity": product.productQuantity,
        "productSold": product.productSold,
        "productStatus": product.productStatus
      };
      var productFormData = FormData.fromMap(productMap);
      Response response = await dio.post(productUrl,
          data: productFormData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final ProductResponse productResponseData =
          ProductResponse.fromJson(response.data);
      if (productResponseData.success == true) {
        isProductAdded = true;
        return isProductAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isProductAdded;
  }

  Future<ProductResponse?> getAllCategoryProduct(String categoryId) async {
    ProductResponse? productResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$categoryUrl/$categoryId");
      // response.data
      productResponse = ProductResponse.fromJson(response.data);
      if (productResponse.success == true) {
        return productResponse;
      } else {
        productResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productResponse;
  }

  Future<ProductResponse?> getAllProduct() async {
    ProductResponse? productResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get(productUrl);
      // response.data
      productResponse = ProductResponse.fromJson(response.data);
      if (productResponse.success == true) {
        return productResponse;
      } else {
        productResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return productResponse;
  }

/* 
  Future<ProductResponse?> getAllFavoriteProduct() async {
    ProductResponse? productResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      print("================= INSIDE GET FAV================");
      // dio ko response --> server le dine
      Response response = await dio.get("$baseUrl$productFavUrl/$UID");
      // response.data
      productResponse = ProductResponse.fromJson(response.data);
      print("The product response: --> $productResponse");
      print("Is data comming");
      if (productResponse.success == true) {
        print("Did you see");
        return productResponse;
      } else {
        productResponse = null;
      }
    } catch (exception) {
      print("ERROR!");
      print(exception.toString());
    }
    return productResponse;
  }

  Future<bool> addAsFavoriteProduct(String uid, String id) async {
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.post("$baseUrl$productFavUrl/$uid/$id");
      // response.data
      return response.data['success'];
    } catch (exception) {
      debugPrint(exception.toString());
    }
    return false;
  }
  */
}
