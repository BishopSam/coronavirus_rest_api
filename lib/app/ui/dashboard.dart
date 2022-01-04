import 'dart:io';

import 'package:coronavirus_rest_api/app/repositories/data_repositories.dart';
import 'package:coronavirus_rest_api/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:coronavirus_rest_api/app/ui/endpoint_card.dart';
import 'package:coronavirus_rest_api/app/ui/last_updated_status_text.dart';
import 'package:coronavirus_rest_api/app/ui/show_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  

  EndpointsData? _endpointsData;

  Future<void> _updateData () async {
    try{
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsData;
    });} on SocketException catch (_){
      showAlertDialog(context: context, title: 'Connection Error', content: 'Could not retrieve data. Please try again later.', defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(context: context, title: 'Unkown Error', content: 'Please contact support or try again later.', defaultActionText: 'OK');
    }

  }

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }
  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedStatusFormatter(lastUpdated:  _endpointsData != null ? _endpointsData?.values[Endpoints.cases]?.date : null

    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coronavirus Tracker'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdateStatusText(text: formatter.lastUpdatedStatusText()),
            for ( var endpoint in Endpoints.values) 
            EndpointCard(endpoints:endpoint, value: _endpointsData != null ? _endpointsData!.values[endpoint]?.value : null),
          ],
        ),
      ),
      
    );
  }
}