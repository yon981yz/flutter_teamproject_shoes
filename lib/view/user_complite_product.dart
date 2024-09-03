import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          children: [
            Text('구매가 확정되었습니다.'),
            FutureBuilder(
              future: handler.queryuserpurchase(), 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text('구매가 확정되었습니다.'),
                      Text('주문번호'),
                      Text(snapshot.data![0].toString()),
                      Text(snapshot.data![1].toString()),
                      Text('매장 키오스크를\n이용하여 제품을 수령하세요.'),
                    ],
                  );
                }else{
                  return Center(
                    child: Text('다시 시도해주세요.'),
                  );
                }
              }
              ),
              ElevatedButton(
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
                  ]
                  );
                }, 
                child: Text('상세 정보')
                ),
          ],
        ),
      ),  
    );
  }
}
