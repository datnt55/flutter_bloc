import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_f99/network/api_helper.dart';
import 'package:flutter_app_f99/network/response/banner_response.dart';
import 'package:flutter_app_f99/network/response/quick_access_response.dart';
import 'package:http/http.dart' as http;

class CatalogRepository {
  final successCode = 200;

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
      throw Exception('failed to load banner');
    }
  }

}
