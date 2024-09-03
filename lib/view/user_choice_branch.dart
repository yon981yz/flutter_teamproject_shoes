import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/purchase.dart';
import 'package:flutter_teamproject_shoes/view/user_complite_product.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';


class UserChoiceBranch extends StatefulWidget {
  const UserChoiceBranch({super.key});

  @override
  State<UserChoiceBranch> createState() => _UserChoiceBranchState();
}

class _UserChoiceBranchState extends State<UserChoiceBranch> {
  late CustomerHandler handler;
  late int radioValue;
  var value=Get.arguments ??'___';
  late String userId;
  final box = GetStorage();  

  @override
  void initState() {
    super.initState();
    radioValue=0;
    handler=CustomerHandler();

    userId = "";
    // iniStorage();    
  }

  // iniStorage() {
  //   userId = box.read('p_userID');
  // }  

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
            Text('매장 위치 선택'),
            Row(
              children: [
                Radio(
                  value: 0, 
                  groupValue: radioValue, 
                  onChanged: (value) {
                    radioChange(value);
                  },),
                  Text('SB Market 강남점')
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 1, 
                  groupValue: radioValue, 
                  onChanged: (value) {
                    radioChange(value);
                  },),
                  Text('SB Market 신사점')                  
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: radioValue, 
                  onChanged: (value) {
                    radioChange(value);
                  },),
                  Text('SB Market 잠실점'),                  
              ],
            ),
            ElevatedButton(
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
                ]
                );
              }, 
              child: Text('구매 확정'))
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
    id: Random().nextInt(9999),
    shoesid: value[7],
    accountid: 'asfd',
    branchid: radioValue+1,
    salesprice: value[3],
    purchasedate: DateTime.now().toString(),
    collectionstatus: '미수령',
    collectiondate: ''
      );
      int result = await handler.insertPurchase(purchaseInsert);
      if(result!=0){
      }
  }
}