import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/model/userlist.dart';
import 'package:flutter_teamproject_shoes/vm/kiosk_handler.dart';
import 'package:get/get.dart';

class CustProductCheck extends StatefulWidget {
  const CustProductCheck({super.key});

  @override
  State<CustProductCheck> createState() => _CustProductCheckState();
}

class _CustProductCheckState extends State<CustProductCheck> {
  KioskHandler kioskHandler = KioskHandler();
  var value = Get.arguments ?? '_';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수령'),
      ),
      body: FutureBuilder(
        future: kioskHandler.querykioskList(value), // Use the initialized future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: data.map<Widget>((userlist) { 
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.memory(
                          userlist.shoesimage,
                          height: 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userlist.shoesName,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userlist.shoesSize.toString(),
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  userlist.shoesColor,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  updateAction(userlist); // Pass userlist correctly
                                },
                                child: const Icon(Icons.check),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            // Case when there is an error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Case when no data is available and no error
            return const Center(
              child: Text('No data available'),
            );
          }
        }, //
      ),
    );
  }


  // -- Functions ---
    Future updateAction(Userlist userlist) async {
    var collectionstatusUpdate = Purchase(
      id: userlist.id,
      salesprice: userlist.salesprice, 
      purchasedate: userlist.purchasedate,
      collectiondate: userlist.collectiondate,
      collectionstatus: '수령완', 
      shoesid: userlist.shoesSize, 
      accountid: userlist.accountName, 
      branchid: userlist.branchid,
      );
    int result = await kioskHandler.updateTransfer(collectionstatusUpdate);
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
            Get.back();
          }, 
          child: const Text('ok')
        ),
      ]
    );
  } 

}// END
