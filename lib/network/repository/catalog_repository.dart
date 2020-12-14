import 'dart:convert';

import 'package:flutter_app_f99/network/api_helper.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/product_detail_response.dart';
import 'package:flutter_app_f99/network/response/product_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:flutter_app_f99/network/response/session_product_response.dart';
import 'package:http/http.dart' as http;

class CatalogRepository {
  final successCode = 200;

  // ignore: missing_return
  Future<List<BannerData>> getBanner() async {
    final response = await http.get(APIHelper.url_banner, headers: {
      'Ocp-Apim-Subscription-Key': APIHelper.security_code,
      'Location': 'b4bb3e8f-8f73-4f3a-8ea9-7d95147bcc68'
    });
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      try{
        return BannerResponse.fromJson(jsonResponse).data;
      }on Exception catch (e){
        print(e);
      }

    } else {
      throw Exception('failed to load banner');
    }
  }

  // ignore: missing_return
  Future<List<QuickAccessData>> getQuickAccess() async {
    final response = await http.get(APIHelper.url_quick_access, headers: {
      'Ocp-Apim-Subscription-Key': APIHelper.security_code,
      'Location': 'b4bb3e8f-8f73-4f3a-8ea9-7d95147bcc68'
    });
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      try{
        return QuickAccess.fromJson(jsonResponse).data;
      }on Exception catch (e){
        print(e);
      }

    } else {
      throw Exception('failed to load quick access');
    }
  }

  // ignore: missing_return
  Future<List<SessionData>> getSession() async {
    final response = await http.get(APIHelper.url_list_section, headers: {
      'Ocp-Apim-Subscription-Key': APIHelper.security_code,
      'Location': 'b4bb3e8f-8f73-4f3a-8ea9-7d95147bcc68'
    });
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      try{
        return SessionProduct.fromJson(jsonResponse).data;
      }on Exception catch (e){
        print(e);
      }

    } else {
      throw Exception('failed to load session');
    }
  }

  // ignore: missing_return
  Future<List<Product>> getListProductOfCollection(String categoryId) async {
    var queryParams = {
      'pageNo': '2',
      'pageSize': '0'
    };
    String queryString = Uri(queryParameters: queryParams).query;

    var uri = APIHelper.url_list_product + categoryId + '?' + queryString;

    final response = await http.get(uri , headers: {
      'Ocp-Apim-Subscription-Key': APIHelper.security_code,
      'Location': 'b4bb3e8f-8f73-4f3a-8ea9-7d95147bcc68'
    }, );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      try{
        CampaignData campaignData = CampaignListResponse.fromJson(jsonResponse).data;
        return campaignData.items;
      }on Exception catch (e){
        print(e);
      }

    } else {
      throw Exception('failed to load session');
    }
  }

  // ignore: missing_return
  Future<ProductDetail> getProductDetail(String productId) async {
    var uri = APIHelper.url_product_detail + productId;

    final response = await http.get(uri , headers: {
      'Ocp-Apim-Subscription-Key': APIHelper.security_code,
      'Location': 'b4bb3e8f-8f73-4f3a-8ea9-7d95147bcc68'
    }, );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == successCode) {
      try{
        return ProductDetail.fromJson(jsonResponse);
      }on Exception catch (e){
        print(e);
      }

    } else {
      throw Exception('failed to load session');
    }
  }

}
