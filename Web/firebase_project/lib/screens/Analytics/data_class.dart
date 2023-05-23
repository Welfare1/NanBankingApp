class SalesData {
  final String month;
  final int sales;
  const SalesData(this.month, this.sales);

  factory SalesData.fromJson(Map<String, dynamic> parsedJson) {
    return SalesData(parsedJson['month'].toString(), parsedJson['sales']);
  }

  static List<Map<String, dynamic>> chartSalesData = [
    {"month": "Jan", "sales": 10000},
    {"month": "feb", "sales": 20000},
    {"month": "Avr", "sales": 25000},
    {"month": "Mar", "sales": 15000},
    {"month": "mai", "sales": 40000}
  ];
}
