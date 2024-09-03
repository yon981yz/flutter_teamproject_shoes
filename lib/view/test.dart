import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late MgtHandler mgtHandler; 
  late String orderNumber;
  late TextEditingController dateController;
  late TextEditingController collectionController;
  late TextEditingController shoesNumberController;
  late DateTime _selectedDate;
  late int radioValue;

  @override
  void initState() {
    orderNumber = randomOrderNumber();
    super.initState();

    mgtHandler = MgtHandler();
    dateController = TextEditingController();
    collectionController = TextEditingController();
    shoesNumberController = TextEditingController();
    _selectedDate = DateTime.now();
    radioValue = 0;

    collectionController.text = '미수령';
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
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
                padding: const EdgeInsets.all(50.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/Rectangle.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('구매 확인'),
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(orderNumber),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                      onTap: () {
                        dateChange();
                      },
                      readOnly: true,
                      controller: dateController,
                      decoration: const InputDecoration(
                        labelText: '배송날짜를 입력해주세요',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: shoesNumberController,
                    decoration: const InputDecoration(labelText: '신발 번호'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Radio(
                      value: 0,
                      groupValue: radioValue,
                      onChanged: (value) => radioChange(value),
                    ),
                    const Text('강남'),
                    Radio(
                      value: 1,
                      groupValue: radioValue,
                      onChanged: (value) => radioChange(value),
                    ),
                    const Text('신사'),
                    Radio(
                      value: 2,
                      groupValue: radioValue,
                      onChanged: (value) => radioChange(value),
                    ),
                    const Text('잠실'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    readOnly: true,
                    controller: collectionController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    insertAction();
                  },
                  child: const Text('입력'),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  //Function
  Future insertAction() async {
    var purchaseInsert = Purchase(
      id: int.parse(orderNumber),
      salesprice: 250000,
      accountid: '123',
      purchasedate: dateController.text.trim(),
      shoesid: int.parse(shoesNumberController.text.trim()),
      branchid: radioValue+1,
      collectionstatus: collectionController.text.trim(),
    );
    int result = await mgtHandler.purchaseShoes(purchaseInsert);
    if (result != 0) {
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
        title: 'input result',
        middleText: 'input complete',
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        barrierDismissible: false,
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('ok')),
        ]);
  }

  dateChange() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              maximumYear: 2030,
              minimumYear: 2020,
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: (DateTime date) {
                _selectedDate = date;
                dateController.text = formatDate(date);
                setState(() {});
              },
            ),
          ),
        );
      },
      barrierDismissible: true,
    );
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  getKind(radioValue) {
    String returnValue = '';
    switch (radioValue) {
      case 0:
        returnValue = '강남';
      case 1:
        returnValue = '신사';
      case 2:
        returnValue = '잠실';
    }
    return returnValue;
  }

  radioChange(int? value) {
    radioValue = value!;
    setState(() {});
  }

String randomOrderNumber() {
  int randomNumber = Random().nextInt(999999);
  DateTime date = DateTime.now();
  formatDate(date);
  String result = '${formatDate2(date)}${randomNumber.toString().padLeft(6, '0')}';
  return result;
}

  String formatDate2(DateTime date) {
    final DateFormat formatter = DateFormat('yyyyMMdd');
    return formatter.format(date);
  }

}