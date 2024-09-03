import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserMyInfo extends StatefulWidget {
  const UserMyInfo({super.key});

  @override
  State<UserMyInfo> createState() => _UserMyInfoState();
}

class _UserMyInfoState extends State<UserMyInfo> {

  // Property
  late TextEditingController userIdController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  CustomerHandler customerHandler = CustomerHandler();

  late String userId;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController(text: box.read('p_userID'));
    nameController = TextEditingController();
    phoneController = TextEditingController();

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
        title: const Text('내정보'),
      ),
      body: FutureBuilder(
        future: customerHandler.queryMyinfo(userIdController.text.trim()), 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ID',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                snapshot.data![index].id,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                snapshot.data![index].name,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '전화번호',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                snapshot.data![index].phone,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 450,
                        height: 400,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(-30/360), // 360도중에 45도로,
                          child: Image.asset(
                            'images/shoses.png',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            }, 
                            child: const Text('확인'),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              );
          }else{
          return const Text('할일을 추가해 주세요');
        }
        }
      ),
    );
  }
}// END
