class Topbrand {
  final String brand;
  final int totalSales;

  Topbrand({
    required this.brand,
    required this.totalSales,
  });

  Topbrand.fromMap(Map<String, dynamic> res)
  : brand = res['brand'],
  totalSales = res['totalsales'];
}