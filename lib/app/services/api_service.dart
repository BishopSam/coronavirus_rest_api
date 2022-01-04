import 'dart:convert';

import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
  final API api;

  APIService(this.api);

  Future<EndpointData> getEndpointData({
    required String? accessToken,
    required Endpoints endpoints,
  }) async {
    final uri = api.endpointUri(endpoints);
    final response = await http.get(
      uri,
      headers: {'Authorization' : 'Bearer $accessToken'},
      
    );

    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      if(data.isNotEmpty){
        final Map<String, dynamic> endpointData = data[0];
        final String? responseJsonKeys = _responseJsonKeys[endpoints];
        int value = endpointData[responseJsonKeys];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);
        return EndpointData(value: value, date: date);
      }
    }
 if (kDebugMode) {
      print(
          "Request ${api.tokenUri()} failed \nResponse: ${response.statusCode} ${response.reasonPhrase}");
    }
  throw response;
  }

     static final Map<Endpoints, String> _responseJsonKeys = {
      Endpoints.cases : 'cases',
      Endpoints.casesConfirmed : 'data',
      Endpoints.casesSuspected : 'data',
      Endpoints.deaths : 'data',
      Endpoints.recovered : 'data'
    };


  Future<String> getAccessToken() async {
    final response = await http.post(api.tokenUri(), headers: {
      "Authorization": "Basic ${api.apiKey}",
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    if (kDebugMode) {
      print(
          "Request ${api.tokenUri()} failed \nResponse: ${response.statusCode} ${response.reasonPhrase}");
    }

    throw response;
  }
}
