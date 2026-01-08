import 'dart:convert';
import 'dart:developer';

import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/report/agency_claim_model.dart';
import 'package:kh_logistics_internal_demo/models/report/agency_send_model.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportRequest {
  Future<AgencySendModel> getAgencySend(
      String dateFrom, String darteTo, int branchId) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/report/agencySend');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "dateFrom": dateFrom,
      "dateTo": darteTo,
      "branchId": branchId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('report agency send => : ${response.body}');
      return AgencySendModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  Future<ReportAgencyClaimModel> getAgencyClaim(
      String dateFrom, String darteTo, int branchId) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/report/agencyClaim');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "dateFrom": dateFrom,
      "dateTo": darteTo,
      "branchId": branchId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      log('report agency claim => : ${response.body}');
      return ReportAgencyClaimModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }
}
