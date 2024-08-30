// 구매
class Purchase {
  final int? id;  // 주문id
  final int salesprice; // 결제금액
  final String? purchasedate; // 구매일자
  final String? collectiondate; // 수령일자
  final String collectionstatus; // 수령여부

  Purchase(
    {
      this.id,
      required this.salesprice,
      this.purchasedate,
      this.collectiondate,
      required this.collectionstatus
    }
  );

  Purchase.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  salesprice = res['salesprice'],
  purchasedate = res['purchasedate'],
  collectiondate = res['collectiondate'],
  collectionstatus = res['collectionstatus'];
}