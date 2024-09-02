import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/branch.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/vm/SY.dart';

class UserCompliteProduct extends StatefulWidget {
  const UserCompliteProduct({super.key});

  @override
  State<UserCompliteProduct> createState() => _UserCompliteProductState();
}

class _UserCompliteProductState extends State<UserCompliteProduct> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}class UserCompliteProductPage extends StatefulWidget {
  final int purchaseId;
  final Branch selectedBranch;

  UserCompliteProductPage({
    required this.purchaseId,
    required this.selectedBranch, 
  });

  @override
  _UserCompliteProductState createState() => _UserCompliteProductState();
}

class _UserCompliteProductPageState extends State<UserCompliteProductPage> {
  final SHandler handler = SHandler();

  Future<Purchase?> _getPurchaseById(int purchaseId) async {
    final purchases = await handler.getPurchases();
    try {
      return purchases.firstWhere((purchase) => purchase.id == purchaseId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('구매 확인')), 
      body: FutureBuilder<Purchase?>(
        future: _getPurchaseById(widget.purchaseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Purchase not found'));
          } else {
            final purchase = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주문 번호: ${purchase.id}', style: TextStyle(fontSize: 18)), 
                  SizedBox(height: 10),
                  Text('결제 금액: ${purchase.salesprice}원', style: TextStyle(fontSize: 18)), 
                  SizedBox(height: 10),
                  Text('수령 여부: ${purchase.collectionstatus}', style: TextStyle(fontSize: 18)), 
                  SizedBox(height: 10),
                  Text('선택된 매장: ${widget.selectedBranch.address}', style: TextStyle(fontSize: 18)), 
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: Text('확인'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
