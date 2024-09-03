import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/view/user_home.dart';
import 'package:flutter_teamproject_shoes/view/user_sign_in.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  // Property
  final DatabaseHandler handler = DatabaseHandler();
  final CustomerHandler customerHandler = CustomerHandler();

  late TextEditingController userIdController;
  late TextEditingController passwordController;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    userIdController = TextEditingController();
    passwordController = TextEditingController();

    //초기화
    iniStorage();
  }

  iniStorage() {
    // box.erase();
    box.write('p_userID', "");
  }

  @override
  void dispose() {
    disposeStorage();
    super.dispose();
  }

  disposeStorage() {
    box.write('p_userID', "");
    box.write('p_password', "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.asset(
                    'images/shoses.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'ID를 입력하세요',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: '비밀번호를 입력하세요',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => const UserSignIn(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC06044)),
                      child: const Text(
                        '회원가입',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        checkUser();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF748D65)),
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //--- Functions ---

  checkUser() async {
    int result = await customerHandler.queryLoginCheck(
        userIdController.text.trim(), passwordController.text.trim());
    if (userIdController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      errorSnackBar();
    } else if (result == 1) {
      saveStorage();
      _showDialog();
    } else {
      errorSnackBar();
    }
  }

  errorSnackBar() {
    Get.snackbar('경고', 'ID랑 Password를 확인해 주세요',
        snackPosition: SnackPosition.BOTTOM, // snackBar 나오는 위치
        duration: const Duration(seconds: 2), // 유지되는 시간
        backgroundColor: Theme.of(context).colorScheme.error,
        colorText: Theme.of(context).colorScheme.onError // 스넥바 글씨
        );
  }

  _showDialog() {
    Get.defaultDialog(
        title: '환영합니다 ${box.read('p_userID')}님!',
        middleText: '오늘도 즐거운 쇼핑이 되세요!',
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // 다이알로그를 없애고
              passwordController.text = '';
              Get.to(
                () => const UserHome(),
              );
            },
            child: const Text('확인'),
          )
        ]);
  }

  saveStorage() {
    // ID 저장
    box.write('p_userID', userIdController.text.trim());
  }
} //END