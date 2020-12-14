import 'dart:convert';

import 'package:flutter_app_f99/network/api_helper.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/product_detail_response.dart';
import 'package:flutter_app_f99/network/response/product_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_app_f99/network/response/seller_detail_response.dart';
import 'package:flutter_app_f99/network/response/session_product_response.dart';
import 'package:http/http.dart' as http;

class SellerRepository {
  final successCode = 200;

  // ignore: missing_return
  Future<SellerDetail> getSellerInfo(String sellerId) async {
    var uri = APIHelper.url_seller_detail + sellerId;
    final response = await http.get(uri, headers: {
      'Ocp-Apim-Subscription-Key': APIHelper.security_code,
      'Location': 'b4bb3e8f-8f73-4f3a-8ea9-7d95147bcc68'
    });
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      try {
        return SellerDetail.fromJson(jsonResponse);
      } on Exception catch (e) {
        print(e);
      }
    } else {
      throw Exception('failed to load seller info');
    }
  }
}