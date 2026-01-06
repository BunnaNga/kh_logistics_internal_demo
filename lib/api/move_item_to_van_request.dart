import 'dart:convert';
import 'dart:developer';

import 'package:kh_logistics_internal_demo/activity/input_or_scan_item.dart';
import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/move_item_to_van/move_item_to_van_model.dart';
import 'package:http/http.dart' as http;
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoveItemToVanRequest {
  Future<MoveItemToVanModel> moveItemToVan(
    String date,
    int branchId,
    int destinationToId,
    int vanId,
    String departureTime,
    String scanCode,
    String sysCode,
    int type,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/move-item-to-van/add');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };
    // body request
    final body = jsonEncode({
      "date": date,
      "branchId": branchId,
      "destinationToId": destinationToId,
      "vanId": vanId,
      "departureTime": departureTime,
      "scanCode": scanCode,
      "sysCode": sysCode,
      "type": type
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('move item from branch to van=> ${response.body}');

      return MoveItemToVanModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }
}
