import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_teamproject_shoes/view/user_choice_branch.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/get.dart';

=======
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
>>>>>>> 1b603f7 (page fixing)

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

<<<<<<< HEAD
class _UserProductDetailsState extends State<UserProductDetails> {
  //Property
  late CustomerHandler handler;
  var value=Get.arguments ??'___';


  @override
  void initState() {
    super.initState();
    handler=CustomerHandler();
  }

=======
class _HomeState extends State<Home> {
    late DatabaseHandler handler;

    @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }



>>>>>>> 1b603f7 (page fixing)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
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
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(value[5], width: 50,
                height: 50,),
                Text(value[0])
              ],
            ),
            Image.memory(value[4]),
            Text('${value[3].toString()}원'),
            Text('컬러: ${value[2]}'),
            Text('사이즈: ${value[1].toString()}'),
            ElevatedButton(
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
                ]
                );
              }, 
              child: const Text(
                '구매하기',
              style: TextStyle(
                color: Colors.white
              ),
              )
              )
          ],
=======
        title: const Text('ss'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Image.asset(
                    width: 150,
                    height: 100,
                  ), */
                  Text('코르테즈'),
                ],
              ),
              /* Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'images/pika.png',
                  width: 150,
                  height: 150,
                ),
              ), */
              const Text('가격'),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('품번'),
              ),
              const Text('컬러'),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text('사이즈'),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                  ),
                  child: const Text(
                    '구매하기',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
>>>>>>> 1b603f7 (page fixing)
        ),
      ),
    );
  }
}
