import 'package:coronavirus_rest_api/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  EndpointCardData({required this.color, required this.assetName, required this.title});
  final Color color;
  final String assetName;
  final String title;

  
}

class EndpointCard extends StatelessWidget {
  EndpointCard({ Key? key,required this.endpoints,required this.value }) : super(key: key);
  final Endpoints? endpoints;
  final int? value;

 final Map<Endpoints, EndpointCardData> _cardsData = {
   Endpoints.cases : EndpointCardData(title: 'Cases', assetName: 'assets/count.png', color: const Color(0xFFFFF492)),
   Endpoints.casesSuspected : EndpointCardData(title: 'Suspected Cases', assetName: 'assets/suspect.png', color: const Color(0xFFFFF492)),
  
    Endpoints.casesConfirmed: EndpointCardData(
        title: 'Confirmed cases', assetName: 'assets/fever.png',color: const Color(0xFFE99600)),
    Endpoints.deaths:
        EndpointCardData(title: 'Deaths',assetName: 'assets/death.png',color: const Color(0xFFE40000)),
    Endpoints.recovered:
        EndpointCardData(title: 'Recovered', assetName: 'assets/patient.png', color: const Color(0xFF70A901)),
};


  String get formattedValue {
    if(value == null){
      return '';
    }
    return NumberFormat('#,###,###,###').format(value).toString();
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoints];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                   cardData!.title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(color: cardData.color),
                    ),
              const SizedBox(height: 4,),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(cardData.assetName, color: cardData.color,),
                    Text(
                      // ignore: unnecessary_null_comparison
                      formattedValue,
                      style: Theme.of(context).textTheme.headline5!.copyWith(color: cardData.color),
                    )
              
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}