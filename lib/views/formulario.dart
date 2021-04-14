import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Formulario extends StatefulWidget {
  bool animate;
  List<charts.Series> seriesList;

  initState() async {
    seriesList = await _createSampleData();
    animate = false;
  }

  @override
  _FormularioState createState() => _FormularioState();

  static Future<List<charts.Series<OrdinalSales, String>>>
      _createSampleData() async {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

class _FormularioState extends State<Formulario> {
  @override
  Widget build(BuildContext context) {
    print('start');
    return Scaffold(
      body: charts.BarChart(
        widget.seriesList,
        animate: widget.animate,
        barGroupingType: charts.BarGroupingType.grouped,
      ),
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

void getCurrentDate(String date) async {
  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
  /* setState(() {
    vis.dt_cadastro = formattedDate.toString();
  });*/
}
