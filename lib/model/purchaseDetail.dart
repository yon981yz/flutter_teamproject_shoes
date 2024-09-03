// 구매
class PurchaseDetail{
  final int? id;  
  final String accountName;
  final String accountPhone;
  final String shoesName;
  final int shoesSize;
  final String shoesColor;
  final String shoesBrand;
  final int salesprice; 
  final String? purchasedate; 
  final String? collectiondate; 
  final String collectionstatus; 

  PurchaseDetail(
    {
    this.id,
    required this.accountName,
    required this.accountPhone,
    required this.shoesName,
    required this.shoesSize,
    required this.shoesColor,
    required this.shoesBrand,
    required this.salesprice,
    this.purchasedate,
    this.collectiondate,
    required this.collectionstatus,
    }
  );

  PurchaseDetail.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  accountName = res['accountname'],
  accountPhone = res['accountphone'],
  shoesName = res['shoesname'],
  shoesSize = res['shoessize'],
  shoesColor = res['shoescolor'],
  shoesBrand = res['shoesbrand'],
  salesprice = res['salesprice'],
  purchasedate = res['purchasedate'],
  collectiondate = res['collectiondate'],
  collectionstatus = res['collectionstatus'];
}