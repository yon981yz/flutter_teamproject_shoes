import 'dart:typed_data';

class Shoes{
  //Property
  final int? id;
  final Uint8List logo;
  final Uint8List image;
  final String name;
  final int size;
  final int salesprice;
  final String color; 
  final String brand; 

  Shoes({
    this.id,
    required this.logo,
    required this.image,
    required this.name,
    required this.size,
    required this.salesprice,
    required this.color,
    required this.brand
  });
  Shoes.fromMap(Map<String, dynamic> inf)
  : id=inf['id'],
  logo=inf['logo'],
  image=inf['image'],
  name=inf['name'],
  size=inf['size'],
  salesprice=inf['salesprice'],
  color=inf['color'],
  brand=inf['brand'];
}