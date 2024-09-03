import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/view/user_complite_product%20copy.dart';
import 'package:flutter_teamproject_shoes/view/user_complite_product.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';


class UserChoiceBranch extends StatefulWidget {
  const UserChoiceBranch({super.key});

  @override
  State<UserChoiceBranch> createState() => _UserChoiceBranchState();
}

class _UserChoiceBranchState extends State<UserChoiceBranch> {
  late String orderNumber;
  late CustomerHandler handler;
  late int radioValue;
  var value=Get.arguments ??'___';
  late String userId;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    orderNumber = randomOrderNumber();
    radioValue=0;
    handler=CustomerHandler();

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
        title: Column(children: [
          Text(
            'SB Market',
            style: TextStyle(
                color: Color(0xFF776661),
                fontSize: 27,
                fontFamily: 'Figma Hand',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ]),
        toolbarHeight: 100,
        backgroundColor: Color(0xFFCFD2A5),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('매장 위치 선택',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Radio(
                    value: 0, 
                    groupValue: radioValue, 
                    onChanged: (value) {
                      radioChange(value);
                    },),
                    Text('SB Market 강남점',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Radio(
                    value: 1, 
                    groupValue: radioValue, 
                    onChanged: (value) {
                      radioChange(value);
                    },),
                    Text('SB Market 신사점',
                    style: TextStyle(
                      fontSize: 17
                    ),
                    )                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: radioValue, 
                    onChanged: (value) {
                      radioChange(value);
                    },),
                    Text('SB Market 잠실점',
                    style: TextStyle(
                      fontSize: 17
                    ),
                    ),                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFF8E807C)
                ),                           
                onPressed: () {
                  insertAction();
                  Get.to(UserCompliteProduct(),
                  arguments: [
                      value[0],
                      value[1],
                      value[2],
                      value[3],
                      value[4],
                      value[5],
                      value[6],
                      value[7],
                      int.parse(orderNumber),
                  ]
                  );
                }, 
                child: Text('구매 확정',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
                )
                ),
            )
          ],
        ),
      ),
    );
  }
    radioChange(int? value) {
    radioValue = value!;
    setState(() {});
  }

    insertAction() async{
    var purchaseInsert=Purchase(
    id: int.parse(orderNumber),
    shoesid: value[7],
    accountid: userId,
    branchid: radioValue+1,
    salesprice: value[3],
    purchasedate: formatDate(DateTime.now()),
    collectionstatus: '미수령',
    collectiondate: ''
      );
      int result = await handler.insertPurchase(purchaseInsert);
      if(result!=0){
      }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
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