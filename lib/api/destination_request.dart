import 'dart:convert';
import 'dart:developer';
import 'package:kh_logistics_internal_demo/api/app_url.dart';
import 'package:kh_logistics_internal_demo/models/destination/destination_from_respone.dart';
import 'package:kh_logistics_internal_demo/models/destination/destination_to_respone.dart';
import 'package:kh_logistics_internal_demo/util/constrain.dart';
import 'package:kh_logistics_internal_demo/util/value_statics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Destination {
  Future<DestinationFromRespone> destinationFrom(String searchText) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/destination/destination-from');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "page": 1,
      "rowsPerPage": 1000, // increase to match Swagger
      "searchText": searchText,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // log('des from ${response.body}');
      return DestinationFromRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }

  Future<DestinationToRespone> destinationTo(
      String searchText, int destinationFromId) async {
    final prefs = await SharedPreferences.getInstance();

    final url = Uri.parse('${AppUrl().baseUrl}/destination/destination-to');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': prefs.getString(Constrain.TOKEN) ?? '',
    };

    // Send params directly at root, not inside "filter"
    final body = jsonEncode({
      "page": 1,
      "rowsPerPage": 1000, // increase to match Swagger
      "searchText": searchText,
      "destinationFromId": destinationFromId,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // log('des to ///// ${response.body}');
      return DestinationToRespone.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load destination!');
    }
  }
}
