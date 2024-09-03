// 구매
class Purchase {
  final int? id;  // 주문id
  final int salesprice; // 결제금액
  final String? purchasedate; // 구매일자
  final String? collectiondate; // 수령일자
  final String collectionstatus; // 수령여부
  final int branchid ;
  final String accountid ;
  final int shoesid ;

  Purchase(
    {
      this.id,
      required this.salesprice,
      this.purchasedate,
      this.collectiondate,
      required this.collectionstatus,
      required this.branchid,
      required this.accountid,
      required this.shoesid,

    }
  );

  Purchase.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  salesprice = res['salesprice'],
  purchasedate = res['purchasedate'],
  collectiondate = res['collectiondate'],
  collectionstatus = res['collectionstatus'],
  branchid = res['branchid'],
  accountid = res['accountid'],
  shoesid = res['shoesid'];
}