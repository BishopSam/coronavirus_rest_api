import 'package:coronavirus_rest_api/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endpointValueKey(Endpoints endpoint) => '$endpoint/value';
  static String endpointDateKey(Endpoints endpoint) => '$endpoint/date';

  EndpointsData getData () {
    Map<Endpoints, EndpointData> values = {};
    for (var endpoint in Endpoints.values) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));
      if (value != null && dateString != null){
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(value: value, date: date);
      }
    }
    return EndpointsData(values: values);
  }

  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointsData) async{
      await sharedPreferences.setInt(endpointValueKey(endpoint), endpointsData.value);
      await sharedPreferences.setString(endpointDateKey(endpoint), endpointsData.date!.toIso8601String());
     });

  }

  
}