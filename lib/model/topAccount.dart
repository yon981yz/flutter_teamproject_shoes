class Topaccount {
  final String accountId;
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
  : accountId = res['accountid'],
    accountName = res['accountname'],
    purchaseCount = res['purchasecount'],
    totalSales = res['totalsales'];

}
