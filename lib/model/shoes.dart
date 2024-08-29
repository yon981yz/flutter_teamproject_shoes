class Shoes{
  //Property
  final int? id;
  final String name;
  final int size;
  final int salesprice;
  final DateTime receiptdate; //??

  Shoes({
    this.id,
    required this.name,
    required this.size,
    required this.salesprice,
    required this.receiptdate
  });
  Shoes.fromMap(Map<String, dynamic> inf)
  : id=inf['id'],
  name=inf['name'],
  size=inf['size'],
  salesprice=inf['salesprice'],
  receiptdate=inf['receiptdate'];
}