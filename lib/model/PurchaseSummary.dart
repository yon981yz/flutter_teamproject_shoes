class PurchaseSummary {
  final int count;
  final int total;

  PurchaseSummary({
    required this.count,
    required this.total,
  });

  PurchaseSummary.fromMap(Map<String, dynamic> res)
  : count = res['count'],
  total = res['total'];
}