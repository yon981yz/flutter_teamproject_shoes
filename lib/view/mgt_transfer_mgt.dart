import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/view/mgt_transfer_add.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';

class MgtTransferMgt extends StatefulWidget {
  const MgtTransferMgt({super.key});

  @override
  State<MgtTransferMgt> createState() => _MgtTransferMgtState();
}

class _MgtTransferMgtState extends State<MgtTransferMgt> {
  late MgtHandler mgtHandler;
  late TextEditingController searchEditingController;

  @override
  void initState() {
    super.initState();
    mgtHandler = MgtHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('images/Rectangle.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('최근 주문 및 수령 검색'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                          Get.to(() => const MgtTransferAdd())!
                              .then((value) => reloadData());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('배송추가 +')),
                ],
              ),
            ),
            SizedBox(
              width: 1200,
              height: 700,
              child: FutureBuilder(
                  future: mgtHandler.queryTransfer(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      List<DataRow> rows = data.map((transfer) {
                        return DataRow(cells: [
                          DataCell(Text(transfer.id.toString())),
                          DataCell(Text(transfer.date.toString())),
                          DataCell(Text(transfer.shoesid.toString())),
                          DataCell(Text(transfer.shoesname)),
                          DataCell(Text(transfer.branchname)),
                          DataCell(Text(transfer.collectionstatus)),
                        ]);
                      }).toList();
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('배송번호')),
                          DataColumn(label: Text('배송 날짜')),
                          DataColumn(label: Text('품번')),
                          DataColumn(label: Text('품명')),
                          DataColumn(label: Text('지점명')),
                          DataColumn(label: Text('수령여부')),
                        ],
                        rows: rows,
                      );
                    } else {
                      return DataTable(
                        // dataRowColor: const Color.fromARGB(255, 238, 238, 238),
                        columns: const [
                          DataColumn(label: Text('배송번호')),
                          DataColumn(label: Text('배송 날짜')),
                          DataColumn(label: Text('품번')),
                          DataColumn(label: Text('품명')),
                          DataColumn(label: Text('지점명')),
                          DataColumn(label: Text('수령여부')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                          ]),
                        ],
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  /// function

reloadData() {
  setState(() {});
}
}///END