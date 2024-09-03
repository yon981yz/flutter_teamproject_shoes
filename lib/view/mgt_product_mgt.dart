import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/view/mgt_product_add.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:flutter_teamproject_shoes/vm/kiosk_handler.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';

class MgtProductMgt extends StatefulWidget {
  const MgtProductMgt({super.key});

  @override
  State<MgtProductMgt> createState() => _MgtProductMgtState();
}

class _MgtProductMgtState extends State<MgtProductMgt> {

    late KioskHandler kioskHandler;
    late MgtHandler mgtHandler;
    late TextEditingController searchEditingController;
    late Future<List<Shoes>> searchFutureName;
    late CustomerHandler customerHandler; 


  @override
  void initState() {
    super.initState();
    kioskHandler = KioskHandler();
    mgtHandler = MgtHandler();
    customerHandler = CustomerHandler();

    searchEditingController = TextEditingController();

    searchFutureName = Future.value([]);
  }

  performSearchName() {
    final searchText = searchEditingController.text.trim();
      if (searchText.isNotEmpty) {
        searchFutureName = mgtHandler.queryShoesSearch(searchText);
      } else {
        searchFutureName = Future.value([]);
      }
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
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
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: SizedBox(
                  width: 500,
                  height: 40,
                  child: TextField(
                    controller: searchEditingController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          performSearchName();
                        },
                        icon: const Icon(Icons.search)
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.to(() => const MgtProductAdd())!
                              .then((value) => reloadData());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('상품추가 +')),
                  ],
                ),
              ),
              searchEditingController.text.trim().isEmpty
              ? SizedBox(
                width: 1200,
                height: 700,
                child: FutureBuilder<List<Shoes>>(
                    future: mgtHandler.queryShoes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        List<DataRow> rows = data.map((shoes) {
                          return DataRow(cells: [
                            DataCell(
                              Image.memory(
                                shoes.image,
                                width: 100,
                                height: 50,
                              )
                            ),
                            DataCell(Text(shoes.brand)),
                            DataCell(Text(shoes.id.toString())),
                            DataCell(Text(shoes.name)),
                            DataCell(Text(shoes.salesprice.toString())),
                          ]);
                        }).toList();
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('이미지')),
                            DataColumn(label: Text('제조사')),
                            DataColumn(label: Text('품번')),
                            DataColumn(label: Text('제품명')),
                            DataColumn(label: Text('원가')),
                          ],
                          rows: rows,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                  }),
              )

            : SizedBox(
                width: 1200,
                height: 700,
                child: FutureBuilder<List<Shoes>>(
                    future: searchFutureName,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        List<DataRow> rows = data.map((shoes) {
                          return DataRow(cells: [
                            DataCell(
                              Image.memory(
                                shoes.image,
                                width: 100,
                                height: 50,
                              )
                            ),
                            DataCell(Text(shoes.brand)),
                            DataCell(Text(shoes.id.toString())),
                            DataCell(Text(shoes.name)),
                            DataCell(Text(shoes.salesprice.toString())),
                          ]);
                        }).toList();
                        return DataTable(
                          columns: const [
                            DataColumn(label: Text('이미지')),
                            DataColumn(label: Text('제조사')),
                            DataColumn(label: Text('품번')),
                            DataColumn(label: Text('제품명')),
                            DataColumn(label: Text('원가')),
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
        ),
      ),
    );
  }

  reloadData() {
    setState(() {});
  }

}// END
