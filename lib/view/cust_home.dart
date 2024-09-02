import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/view/cust_product_check.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:get/get.dart';

class CustHome extends StatefulWidget {
  const CustHome({super.key});

  @override
  State<CustHome> createState() => _CustHomeState();
}

class _CustHomeState extends State<CustHome> {
  // Property

  DatabaseHandler databaseHandler = DatabaseHandler();
  CustomerHandler customerHandler = CustomerHandler();

  late TextEditingController numberController;
  late List<int> numberResult;
  late bool button1Visible;
  late bool button2Visible;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
    button1Visible = false;
    button2Visible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: Image.asset(
                'images/shoses.png',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '주문번호',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: numberController,
                      onTap: () {
                        button1Visible = true;
                        button2Visible = false;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Visibility(
                  visible: button1Visible,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber1();
                                  },
                                  child: const Text('1'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber2();
                                  },
                                  child: const Text('2'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber3();
                                  },
                                  child: const Text('3'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber4();
                                  },
                                  child: const Text('4'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber5();
                                  },
                                  child: const Text('5'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber6();
                                  },
                                  child: const Text('6'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber7();
                                  },
                                  child: const Text('7'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber8();
                                  },
                                  child: const Text('8'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber9();
                                  },
                                  child: const Text('9'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    numberController.text = '';
                                  },
                                  child: const Text('취소'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewNumber5();
                                  },
                                  child: const Text('0'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    button1Visible = false;
                                    button2Visible = true;
                                    setState(() {});
                                  },
                                  child: const Text('입력'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: button2Visible,
                  child: ElevatedButton(
                    onPressed: () {
                      checknumber();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 100),
                        backgroundColor: const Color(0xFF758D65),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        )),
                    child: const Text(
                      '확인',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Functions ---

  checknumber()async{
    int result = await customerHandler.queryPurchaseNumber(numberController.text);
    if(result == 1){
      Get.to(
        ()=> const CustProductCheck()
      );
    }else{
      _showDialog();
    }
  }

  _showDialog(){
    Get.defaultDialog(
      title: '번호를 확인해주세요',
      middleText: '주문번호를 다시 확인해 주세요',
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); 
            },
            child: const Text('확인'),
          )
        ]);

  }

  showNumner() {
    numberController.text = '';
  }

  viewNumber1() {
    numberController.text += '1';
  }

  viewNumber2() {
    numberController.text += '2';
  }

  viewNumber3() {
    numberController.text += '3';
  }

  viewNumber4() {
    numberController.text += '4';
  }

  viewNumber5() {
    numberController.text += '5';
  }

  viewNumber6() {
    numberController.text += '6';
  }

  viewNumber7() {
    numberController.text += '7';
  }

  viewNumber8() {
    numberController.text += '8';
  }

  viewNumber9() {
    numberController.text += '9';
  }

  viewNumber0() {
    numberController.text += '0';
  }
}// END
