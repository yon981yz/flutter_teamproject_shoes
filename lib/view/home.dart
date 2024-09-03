import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/branch.dart';
import 'package:flutter_teamproject_shoes/view/cust_home.dart';
import 'package:flutter_teamproject_shoes/view/mgt_home.dart';
import 'package:flutter_teamproject_shoes/view/user_login.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:flutter_teamproject_shoes/vm/kiosk_handler.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

DatabaseHandler handler = DatabaseHandler();
KioskHandler kioskHandler = KioskHandler();

@override
  void initState() {
    super.initState();
  addBranch();
  }

  Future addBranch()async{
      List<Branch> name = [
      Branch(name: '강남점'),
      Branch(name: '신사점'),
      Branch(name: '잠실점'),
    ];
    await kioskHandler.insertBranches(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    ()=> const MgtHome()
                  );
                }, 
                child: const Text('관리자'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    ()=> const CustHome()
                  );
                }, 
                child: const Text('키오스크'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    ()=> const UserLogin()
                  );
                }, 
                child: const Text('사용자'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -- Functions --

}// END