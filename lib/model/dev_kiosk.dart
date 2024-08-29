import 'dart:typed_data';

// 지점 키오스크 고객 구매용
class DevKiosk {
  final int? id;
  final String address;
  final Uint8List image;
  final String name;
  final int size;
  final String color;
  final int salseprice;
  final String? receiptdate;

  DevKiosk(
    {
      this.id,
      required this.address,
      required this.image,
      required this.name,
      required this.size,
      required this.color,
      required this.salseprice,
      this.receiptdate
    }
  );

  DevKiosk.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  address = res['address'],
  image = res['image'],
  name = res['name'],
  size = res['size'],
  color = res['color'],
  salseprice = res['salseprice'],
  receiptdate = res['receiptdate']
}