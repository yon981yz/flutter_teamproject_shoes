class Topaccount {
  final int accountId;
  final String accountName;
  final int purchaseCount;
  final int totalSales;

  Topaccount({
    required this.accountId,
    required this.accountName,
    required this.purchaseCount,
    required this.totalSales,
  });

  Topaccount.fromMap(Map<String, dynamic> res)
  : accountId = res['accountId'],
    accountName = res['accountName'],
    purchaseCount = res['purchaseCount'],
    totalSales = res['totalSales'];

}
