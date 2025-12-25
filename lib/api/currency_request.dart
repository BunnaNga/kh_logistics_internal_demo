import 'dart:convert';
import 'dart:developer';

import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/currency/currency_respone.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Currency {
  Future<CurrencyRespone> getCurrency(String searchText) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/currency/list');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "page": 1,
      "rowsPerPage": 100, // increase to match Swagger
      "searchText": searchText,
      // "destinationFromId": destinationFromId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('Currency list =>: ${response.body}');
      // log('des to ///// ${response.body}');
      return CurrencyRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }
}
