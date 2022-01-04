import 'package:coronavirus_rest_api/app/services/api_keys.dart';

enum Endpoints{
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  API({required this.apiKey});
  final String apiKey;

  factory API.sandBox() => API(apiKey: APIKeys.ncovSandBoxKey);

  static const String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(scheme: 'https', host: host, path: 'token');

  Uri endpointUri(Endpoints endpoints) => Uri(
    scheme: 'https', host: host, path: _paths[endpoints]

  );

  final Map<Endpoints, String> _paths = {
    Endpoints.cases : "cases",
    Endpoints.casesConfirmed : 'casesConfirmed',
    Endpoints.casesSuspected : 'casesSuspected',
    Endpoints.deaths : 'deaths',
    Endpoints.recovered : 'recovered'


  };
}
