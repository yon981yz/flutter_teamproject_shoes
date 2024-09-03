import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/view/user_home.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/route_manager.dart';

class UserProcuctCheck extends StatefulWidget {
  const UserProcuctCheck({super.key});

  @override
  State<UserProcuctCheck> createState() => _UserProcuctCheckState();
}

class _UserProcuctCheckState extends State<UserProcuctCheck> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Column(children: [
          Text(
            'SB Market',
            style: const TextStyle(
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(value[4]),
            FutureBuilder(
              future: handler.queryuserpurchase(), 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text('주문번호: ${snapshot.data![snapshot.data!.length-1].id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                      ),
                      Text('제품명: ${value[0]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),                      
                      ),
                      Text('Size: ${value[1]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),                      
                      ),
                      Text('매장: ${snapshot.data![snapshot.data!.length-1].branch}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
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
              },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: const Color(0xFF8E807C)
                  ),

                  onPressed: () {
                    Get.to(UserHome(),
                    );
                  }, 
                  child: Text('확인',
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