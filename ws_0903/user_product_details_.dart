import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/customer_handler.dart';
import 'package:flutter_teamproject_shoes/user_choice_branch.dart';
import 'package:get/get.dart';


class UserProductDetails extends StatefulWidget {
  const UserProductDetails({super.key});

  @override
  State<UserProductDetails> createState() => _UserProductDetailsState();
}

class _UserProductDetailsState extends State<UserProductDetails> {
  //Property
  late CustomerHandler handler;
  var value=Get.arguments ??'___';


  @override
  void initState() {
    super.initState();
    handler=CustomerHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'SB Market',
            style: TextStyle(
                color: Color(0xFF776661),
                fontSize: 27,
                fontFamily: 'Figma Hand',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          backgroundColor: const Color(0xFFCFD2A5),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.memory(value[5], width: 50,
                  height: 50,
                  ),
                  Text('  ${value[0]}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,25,),
              child: Image.memory(value[4],
              height: 220,
              fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Text('${value[3].toString()} 원',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,15),
              child: Text('컬러: ${value[2]}',
              style: TextStyle(
                fontSize: 19
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text('사이즈: ${value[1].toString()}',
              style: TextStyle(
                fontSize: 19
              ),            
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFFC06044)
                ),
                onPressed: () {
                  Get.to(
                    ()=> const UserChoiceBranch(),
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
                child: const Text(
                  '구매하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                )
                ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}