import 'dart:convert';
import 'dart:developer';

import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/move_item_from_van/move_item_from_van_model.dart';
import 'package:kh_logistics_internal_demo/models/move_item_to_van/move_item_to_van_model.dart';
import 'package:http/http.dart' as http;
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoveItemFromVanRequest {
  Future<MoveItemFromVanModel> moveItemFromVan(
    String date,
    int branchId,
    int vanId,
    String scanCode,
    String sysCode,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/move-item-from-van/add');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };
    // body request
    final body = jsonEncode({
      "date": date,
      "branchId": branchId,
      "vanId": vanId,
      "scanCode": scanCode,
      "sysCode": sysCode,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('move item from van to branch => ${response.body}');

      return MoveItemFromVanModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }
}
