// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedStatusFormatter {
   LastUpdatedStatusFormatter({required this.lastUpdated});
  final DateTime? lastUpdated;

 String lastUpdatedStatusText () {
   if(lastUpdated!=null){
   final formatter = DateFormat.yMd().add_Hms().format(DateTime.now());
   final lastUpdated = formatter;

   return 'Last Updated Time: $lastUpdated';
   }
   return '';
 }

}

class LastUpdateStatusText extends StatelessWidget {
  const LastUpdateStatusText({ Key? key,required this.text }) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$text',
        textAlign: TextAlign.center,
      ),
    );
  }
}