// services/products/product_service.dart
import 'package:dio/dio.dart';
import 'package:katarasa/constants/constants.dart';

class ApiProduct {
  Future<dynamic> getProductList(
      {int? page, int? limit, String? keyword, String? category}) async {
    try {
      final data = await Dio().get(
          '${Constants.baseUrl}product/get-product-compro',
          queryParameters: {
            'page': page ?? 1,
            'limit': limit ?? 5,
            'keyword': keyword ?? '',
            'category': category ?? '',
            'outlet': '',
            'latitude': '',
            'longitude': '',
          });
      return data.data;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
