import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/transfer.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

class MgtTransferAdd extends StatefulWidget {
  const MgtTransferAdd({super.key});

  @override
  State<MgtTransferAdd> createState() => _MgtTransferAddState();
}

class _MgtTransferAddState extends State<MgtTransferAdd> {
  late MgtHandler mgtHandler;
  late TextEditingController dateController;
  late TextEditingController collectionController;
  late TextEditingController shoesNumberController;
  late TextEditingController brandController;
  late DateTime _selectedDate;
  late int radioValue;

  @override
  void initState() {
    super.initState();

    mgtHandler = MgtHandler();
    dateController = TextEditingController();
    collectionController = TextEditingController();
    shoesNumberController = TextEditingController();
    brandController = TextEditingController();
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
                      child: Text('최근 주문내역'),
                    )
                  ],
                ),
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
    var transInsert = Transfer(
      date: dateController.text.trim(),
      shoesid: int.parse(shoesNumberController.text.trim()),
      branchid: radioValue,
      collection: brandController.text.trim(),
    );
    int result = await mgtHandler.insertTransfer(transInsert);
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
}
