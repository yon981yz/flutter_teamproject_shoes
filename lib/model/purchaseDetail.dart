// 구매
class PurchaseDetail{
  final int? id;  // 주문id
  final int salesprice; // 결제금액
  final String? purchasedate; // 구매일자
  final String? collectiondate; // 수령일자
  final String collectionstatus; // 수령여부
  final String accountName;
  final String accountPhone;
  final String shoesName;
  final int shoesSize;
  final String shoesColor;
  final String shoesBrand;

  PurchaseDetail(
    {
      this.id,
      required this.salesprice,
      this.purchasedate,
      this.collectiondate,
      required this.collectionstatus,
      required this.accountName,
      required this.accountPhone,
      required this.shoesName,
      required this.shoesSize,
      required this.shoesColor,
      required this.shoesBrand,
    }
  );

  PurchaseDetail.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  salesprice = res['salesprice'],
  purchasedate = res['purchasedate'],
  collectiondate = res['collectiondate'],
  collectionstatus = res['collectionstatus'],
  accountName = res['account_name'],
  accountPhone = res['account_phone'],
  shoesName = res['shoes_name'],
  shoesSize = res['shoes_size'],
  shoesColor = res['shoes_color'],
  shoesBrand = res['shoes_brand'];
}