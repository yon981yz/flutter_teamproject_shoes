import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchaseDetail.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';

class MgtOrderSearch extends StatefulWidget {
  const MgtOrderSearch({super.key});

  @override
  State<MgtOrderSearch> createState() => _MgtOrderSearchState();
}

class _MgtOrderSearchState extends State<MgtOrderSearch> {
  late TextEditingController searchController;
  late MgtHandler mgtHandler;
  late Future<List<PurchaseDetail>> searchFutureName;

  @override
  void initState() {
    mgtHandler = MgtHandler();
    searchController = TextEditingController();
    searchFutureName = Future.value([]);
    super.initState();
  }

  performSearchName() {
    final searchText = searchController.text.trim();
      if (searchText.isNotEmpty) {
        searchFutureName = mgtHandler.queryPurchaseDetailsSearch(searchText);
      } else {
        searchFutureName = Future.value([]);
      }
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40,40,40,40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/Rectangle.png'
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('최근 주문 및 수령 검색'),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 500,
                height: 40,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: '주문자명을 입력해주세요',
                    suffixIcon: IconButton(
                      onPressed: () {
                        //
                      }, 
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 1000,
                height: 700,
                child: FutureBuilder<List<PurchaseDetail>>(
                    future: mgtHandler.queryPurchaseDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        List<DataRow> rows = data.map((purchase) {
                          return DataRow(cells: [
                            DataCell(Text(purchase.id.toString())),
                            DataCell(Text(purchase.accountName)),
                            DataCell(Text(purchase.accountPhone)),
                            DataCell(Text(purchase.salesprice.toString())),
                            DataCell(Text(purchase.purchasedate.toString())),
                            DataCell(Text(purchase.collectiondate.toString())),
                            DataCell(Text(purchase.collectionstatus)),
                          ]);
                        }).toList();
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('주문번호')),
                            DataColumn(label: Text('주문자명')),
                            DataColumn(label: Text('전화번호')),
                            DataColumn(label: Text('주문액')),
                            DataColumn(label: Text('주문일')),
                            DataColumn(label: Text('수령일')),
                            DataColumn(label: Text('수령여부')),
                          ],
                          rows: rows,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  }),
              ),
            ],
          ),
        ));
  }
}
