import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/view/user_procuct_check%20copy.dart';
import 'package:flutter_teamproject_shoes/view/user_procuct_check.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/get.dart';

class UserCompliteProduct extends StatefulWidget {
  const UserCompliteProduct({super.key});

  @override
  State<UserCompliteProduct> createState() => _UserCompliteProductState();
}

class _UserCompliteProductState extends State<UserCompliteProduct> {
  var value=Get.arguments ??'___';
  late CustomerHandler handler;

  @override
  void initState() {
    super.initState();
    handler=CustomerHandler();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(
          children: [
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
        backgroundColor: const Color(0xFFCFD2A5),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: handler.queryuserpurchase(), 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text('구매가 확정되었습니다.',
                        style: TextStyle(
                          fontSize: 20
                        ),
                        ),
                      ),
                      Text('주문번호',
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                      Text(snapshot.data![snapshot.data!.length-1].id.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text('선택 지점: ${snapshot.data![snapshot.data!.length-1].branch.toString()}',
                        style: TextStyle(
                          fontSize: 25
                        ),                      
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('매장 키오스크를\n이용하여 제품을 수령하세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 118, 113, 111)
                        ),
                        ),
                      ),
                    ],
                  );
                }else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                else{
                  return Center(
                    child: Text('다시 시도해주세요.'),
                  );
                }
              }
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
                    Get.to(UserProcuctCheck(),
                    arguments: [
                      value[0],
                      value[1],
                      value[2],
                      value[3],
                      value[4],
                      value[5],
                      value[6],
                      value[7], 
                      value[8], 
                    ]
                    );
                  }, 
                  child: Text('상세 정보',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  )
                  ),
              ),
          ],
        ),
      ),  
    );
  }
}