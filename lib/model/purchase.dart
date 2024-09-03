// 구매
class Purchase {
  final int? id;  // 주문번호
  final int salesprice; // 결제금액
  final String? purchasedate; // 구매일자
  final String? collectiondate; // 수령일자
  final String collectionstatus; // 수령여부
  final int shoesid;
  final String accountid;
  final int branchid;

  Purchase(
    {
      this.id,
      required this.salesprice,
      this.purchasedate,
      this.collectiondate,
      required this.collectionstatus,
      required this.shoesid,
      required this.accountid,
      required this.branchid
    }
  );

  Purchase.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  shoesid=res['shoesid'],
  accountid=res['accountid'],
  branchid=res['branchid'],
  salesprice = res['salesprice'],
  purchasedate = res['purchasedate'],
  collectiondate = res['collectiondate'],
  collectionstatus = res['collectionstatus'];
}