import 'dart:convert';
import 'dart:developer';

import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/change_destination_respone.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/goods_transfer_add_respone.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/goods_transfer_history_respone.dart';
import 'package:kh_logistics_internal_demo/models/goods_transfer/return_to_destination_respone.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GoodsTransferRequest {
  // goods transfer add
  Future<GoodsTransferAddRespone> goodsTransferAdd({
    required int destinationFromId,
    required int destinationToId,
    required String senderName,
    required String senderTelephone,
    required String receiverName,
    required String receiverTelephone,
    required int customerId,
    required int transferFee,
    required int deliveryDestinationId,
    required int deliveryFee,
    required int total,
    required int isCod,
    required int paymentBy,
    required int itemTypeId,
    required String itemName,
    required int quantity,
    required int unitFee,
    required int uomId,
    required int totalFee,
    required int itemValue,
    required int itemValueCurrency,
    required int weight,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('${AppUrl().baseUrl}/good-transfer/add');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    final body = jsonEncode({
      "destinationFromId": destinationFromId,
      "destinationToId": destinationToId,
      "senderName": senderName,
      "senderTelephone": senderTelephone,
      "receiverName": receiverName,
      "receiverTelephone": receiverTelephone,
      "customerId": customerId,
      "transferFee": transferFee,
      "deliveryDestinationId": deliveryDestinationId,
      "deliveryFee": deliveryFee,
      "total": total,
      "isCod": isCod,
      "paymentBy": paymentBy,
      "goodInformationList": [
        {
          "itemTypeId": itemTypeId,
          "itemName": itemName,
          "quantity": quantity,
          "unitFee": unitFee,
          "uomId": uomId,
          "totalFee": totalFee,
          "itemValue": itemValue,
          "itemValueCurrency": itemValueCurrency,
          "weight": weight
        }
      ]
    });
    // Log request info before sending
    log('--- Goods Transfer Add Request ---');
    log('URL: $url');
    log('Headers: $headers');
    log('Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('Goods transfer add => ${response.body}');
      return GoodsTransferAddRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  // get list of goods transfered
  Future<GoodsTransferHistoryRespone> getListGoodsTransferHistory(
      String searchText) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/good-transfer/list');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "page": 1,
      "rowsPerPage": 100, // increase to match Swagger
      "searchText": searchText,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('goods transfer history=> ${response.body}');
      return GoodsTransferHistoryRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  // return goods to destination from
  Future<ReturnDestinationRespone> returnDestination(int id, int branchId,
      String sendderTel, String receiverTel, int extraPrice) async {
    final prefs = await SharedPreferences.getInstance();

    final url =
        Uri.parse('${AppUrl().baseUrl}/good-transfer/returnDestination');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "id": id,
      "branchId": branchId,
      "senderTelephone": sendderTel,
      "receiverTelephone": receiverTel,
      "extraPrice": extraPrice,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('return destination => ${response.body}');
      return ReturnDestinationRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  // change destination goods transfer
  Future<ChangeDestinationRespone> changeDestination(
      int id,
      int branchId,
      String sendderTel,
      String receiverTel,
      String destinationToId,
      int extraPrice) async {
    final prefs = await SharedPreferences.getInstance();

    final url =
        Uri.parse('${AppUrl().baseUrl}/good-transfer/changeDestination');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "id": id,
      "branchId": branchId,
      "senderTelephone": sendderTel,
      "receiverTelephone": receiverTel,
      "destinationToId": destinationToId,
      "extraPrice": extraPrice,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('change destination => ${response.body}');
      return ChangeDestinationRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }
}
