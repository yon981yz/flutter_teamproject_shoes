import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:flutter_teamproject_shoes/vm/kiosk_handler.dart';
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
  KioskHandler kioskHandler = KioskHandler();

  late String userId;
  final box = GetStorage();

late Future<List<Purchase>> _userPurchasesFuture;

@override
void initState() {
  super.initState();
  userId = "";
  iniStorage();
}

void iniStorage() {
  userId = box.read('p_userID');
  // _userPurchasesFuture = kioskHandler.queryuserlist(userId);
  setState(() {}); // future 초기화 후 UI 업데이트
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
      future: kioskHandler.queryuserlist(userId), // 여기서 초기화된 future 사용
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('구매내역이 없습니다'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.memory(
                    snapshot.data![index].shoesimage,
                    width: 100,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data![index].shoesName
                        ),
                        Text(
                          snapshot.data![index].shoesColor
                        ),
                        Text(
                          snapshot.data![index].shoesSize.toString()
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          snapshot.data![index].purchasedate.toString()
                        ),
                        Text(
                          snapshot.data![index].collectionstatus
                        ),
                      ],
                    ),
                  )
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