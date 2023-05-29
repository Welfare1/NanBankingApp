import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_project/constants.dart';
import 'package:firebase_project/screens/items/headBox.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Analytics/data_class.dart';

class Analytique extends StatefulWidget {
  const Analytique({super.key});

  @override
  State<Analytique> createState() => _AnalytiqueState();
}

List<SalesData> chartData = [];

class _AnalytiqueState extends State<Analytique> {
  @override
  void initState() {
    loadSalesData();
    print("Init::::");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chartData.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeadMain(mainTitle: "Analytique"),
          Column(
            children: [
              Row(
                children: [
                  Flexible(child: chartSf()),
                  const Flexible(child: SizedBox()),
                  const Flexible(child: SizedBox()),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget chartSf() {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Half yearly sales analysis'),
        series: <ChartSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            dataSource: chartData,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ]);
  }

  loadSalesData() {
    final jsonResponse = SalesData.chartSalesData;
    setState(() {
      for (Map<String, dynamic> i in jsonResponse) {
        chartData.add(SalesData.fromJson(i));
      }
    });
  }
}
