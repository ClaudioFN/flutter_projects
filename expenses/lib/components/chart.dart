import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';


class Chart extends StatelessWidget {
  
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

 List<Map<String, Object>> get groupedTransactions {
    final String defaultLocale = Platform.localeName;
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }
      initializeDateFormatting(defaultLocale);
      return {'day': DateFormat.E(defaultLocale).format(weekDay)[0].toUpperCase(), 'value': totalSum};
    }).reversed.toList();
  }
 
  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 7,
      margin: EdgeInsets.all(21),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  value: double.parse(tr['value'].toString()),
                  percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue),
            );
          }).toList(),
        ),
      ),
    );
  }
}
