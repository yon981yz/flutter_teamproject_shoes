import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/transfer.dart';
import 'package:flutter_teamproject_shoes/model/transferSummary.dart';
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
                      List<DataRow> rows = data.map((transferSummary) {
                        return DataRow(cells: [
                          DataCell(Text(transferSummary.id.toString())),
                          DataCell(Text(transferSummary.date.toString())),
                          DataCell(Text(transferSummary.shoesid.toString())),
                          DataCell(Text(transferSummary.shoesname)),
                          DataCell(Text(transferSummary.branchname)),
                          DataCell(Text(transferSummary.collectionstatus)),
                          DataCell(ElevatedButton(
                            onPressed: () {
                              if (transferSummary.collectionstatus == "미수령"){
                              updateAction(transferSummary);
                              }else{
                                errorSnackbar();
                              }
                              setState(() {});
                            }, 
                            child: const Text ('수령하기')
                            )),
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
                          DataColumn(label: Text('')),
                        ],
                        rows: rows,
                      );
                    } else {
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('배송번호')),
                          DataColumn(label: Text('배송 날짜')),
                          DataColumn(label: Text('품번')),
                          DataColumn(label: Text('품명')),
                          DataColumn(label: Text('지점명')),
                          DataColumn(label: Text('수령여부')),
                          DataColumn(label: Text('')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text('')),
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

  Future updateAction(Transfersummary transferSummary) async {
    var collectionstatusUpdate = Transfer(
        id: transferSummary.id,
        date: transferSummary.date.toString(),
        branchid: transferSummary.branchid,
        shoesid: transferSummary.branchid,
        collectionstatus: '수령완',
        );
    int result = await mgtHandler.updateTransfer(collectionstatusUpdate);
    if(result != 0) {
      _showDialog();
    }
  }

  _showDialog(){
    Get.defaultDialog(
      title: '알림',
      middleText: '수령을 완료하셨습니다',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          }, 
          child: const Text('ok')
        ),
      ]
    );
  } 

  errorSnackbar(){
    Get.snackbar(
      "alert", 
      "이미 수령하였습니다",
      snackPosition: SnackPosition. BOTTOM,
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.error
    );   
  }
}///END