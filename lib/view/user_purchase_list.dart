import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:get_storage/get_storage.dart';

class UserPurchaseList extends StatefulWidget {
  const UserPurchaseList({super.key});

  @override
  State<UserPurchaseList> createState() => _UserPurchaseListState();
}

class _UserPurchaseListState extends State<UserPurchaseList> {
  // Property
  DatabaseHandler handler = DatabaseHandler();
  CustomerHandler customerHandler = CustomerHandler();

  late String userId;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    userId = "";
    iniStorage();
  }

  iniStorage() {
    userId = box.read('p_userID');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userId,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(' 님의 구매내역'),
          ],
        ),
      ),
      body: FutureBuilder(
        future: customerHandler.purchaseList(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('구매내역이 없습니다'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final purchase = snapshot.data![index];
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '주문번호: ${purchase.id}', // 상품 이름을 표시합니다.
                      style:
                          const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold),
                    ),
                    Text('구매 날짜: ${purchase.collectiondate}'), // 구매 날짜
                    Text('가격: ${purchase.salesprice}'), // 가격
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}// END
