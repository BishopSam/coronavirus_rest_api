// ignore_for_file: unnecessary_null_comparison
import 'package:coronavirus_rest_api/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/services/api_service.dart';
import 'package:coronavirus_rest_api/app/services/data_cache_service.dart';
import 'package:coronavirus_rest_api/app/services/endpoint_data.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService,required this.dataCacheService});
 final APIService? apiService;
 final DataCacheService dataCacheService; 

String? _accessToken;

  Future<EndpointData> getEndPointData(Endpoints endpoints) async =>
    await _getDataRefreshingToken(
      onGetData: () => apiService!.getEndpointData(accessToken: _accessToken, endpoints: endpoints)
    );

  EndpointsData getAllEndpointsCachedData () => dataCacheService.getData();

  Future<EndpointsData> getAllEndpointsData() async {
  final endpointsData = await _getDataRefreshingToken(
    onGetData: _getAllEndpointData
  );
  // save to cache
  await dataCacheService.setData(endpointsData);
  return endpointsData;
  }  

  Future<T> _getDataRefreshingToken<T>({Future<T> Function()? onGetData}) async{
       try{
    // ignore: prefer_conditional_assignment
    if(_accessToken == null) {
      _accessToken = await apiService!.getAccessToken();
    }  return await onGetData!();
  } on Response catch (response){
    if(response.statusCode == 401){
      _accessToken == await apiService!.getAccessToken();
      return await onGetData!();
    }
    rethrow;
  }

  }

  Future<EndpointsData> _getAllEndpointData () async {
   final values = await Future.wait([
      apiService!.getEndpointData(accessToken: _accessToken, endpoints: Endpoints.cases),
       apiService!.getEndpointData(accessToken: _accessToken, endpoints: Endpoints.casesSuspected),
        apiService!.getEndpointData(accessToken: _accessToken, endpoints: Endpoints.casesConfirmed),
         apiService!.getEndpointData(accessToken: _accessToken, endpoints: Endpoints.deaths),
          apiService!.getEndpointData(accessToken: _accessToken, endpoints: Endpoints.recovered),
    ]);
    return EndpointsData(values: {
      Endpoints.cases : values[0],
      Endpoints.casesSuspected : values[1],
      Endpoints.casesConfirmed : values[2],
      Endpoints.deaths : values[3],
      Endpoints.recovered : values [4]
    });
  }
}