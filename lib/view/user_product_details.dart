import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/vm/SY.dart';

class UserProductDetailsPage extends StatefulWidget {
  final int purchaseId;

  UserProductDetailsPage({required this.purchaseId});

  @override
  _UserProductDetailsPageState createState() => _UserProductDetailsPageState();
}

class _UserProductDetailsPageState extends State<UserProductDetailsPage> {
  final SHandler handler = SHandler();

  Future<Shoes?> _getShoesByPurchaseId(int purchaseId) async {
    final purchases = await handler.getPurchases();
    
    Purchase? purchase;
    for (var p in purchases) {
      if (p.id == purchaseId) {
        purchase = p;
        break;
      }
    }

    if (purchase == null) return null;

    final shoesList = await handler.getShoes();
    
    Shoes? shoes;
    for (var s in shoesList) {
      if (s.id == purchase.id) {
        shoes = s;
        break;
      }
    }

    return shoes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('제품 세부 정보')),  
      body: FutureBuilder<Shoes?>(
        future: _getShoesByPurchaseId(widget.purchaseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Product not found'));
          } else {
            final shoes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.memory(shoes.image),
                  SizedBox(height: 10),
                  Text('제품명: ${shoes.name}', style: TextStyle(fontSize: 18)),  
                  SizedBox(height: 10),
                  Text('브랜드: ${shoes.brand}', style: TextStyle(fontSize: 18)), 
                  SizedBox(height: 10),
                  Text('사이즈: ${shoes.size}', style: TextStyle(fontSize: 18)), 
                  SizedBox(height: 10),
                  Text('색상: ${shoes.color}', style: TextStyle(fontSize: 18)),  
                  SizedBox(height: 10),
                  Text('가격: ${shoes.salesprice}원', style: TextStyle(fontSize: 18)),  
                ],
              ),
            );
          }
        },
      ),
    );
  }
}