import 'dart:typed_data';

class Topfiveshoes {
  final Uint8List image;
  final int shoesid;
  final int shoesname;
  final int shoesbrand;
  final int totalOrder;
  final int totalsales;

  Topfiveshoes({
    required this.image,
    required this.shoesid,
    required this.shoesname,
    required this.shoesbrand,
    required this.totalOrder,
    required this.totalsales,
  });

  Topfiveshoes.fromMap(Map<String, dynamic> res)
  : image = res['image'],
    shoesid = res['shoesid'],
    shoesname = res['shoesname'],
    shoesbrand = res['shoesbrand'],
    totalOrder = res['totalOrder'],
    totalsales = res['totalsales'];
}