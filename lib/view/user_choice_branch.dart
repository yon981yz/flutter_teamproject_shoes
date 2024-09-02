import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/vm/database_handler.dart';
import 'package:get/get.dart';

class UserChoiceBranch extends StatefulWidget {
  const UserChoiceBranch({super.key});

  @override
  State<UserChoiceBranch> createState() => _UserChoiceBranchState();
}

class _UserChoiceBranchState extends State<UserChoiceBranch> {
  late TextEditingController searchController;
  late DatabaseHandler handler;
  var value = Get.arguments ?? '___';
  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: [
          const Text(
            'SB Market',
            style: TextStyle(
                color: Color(0xFF776661),
                fontSize: 27,
                fontFamily: 'Figma Hand',
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              SizedBox(
                width: 300,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
                    child: TextField(
                      controller: searchController,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    //searchAction();
                  },
                  icon: const Icon(Icons.search)),
            ]),
          ),
        ]),
        toolbarHeight: 150,
        backgroundColor: const Color(0xFFCFD2A5),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          //
        },
        backgroundColor: const Color(0xD3776661),
        child: const Text(
          '선택',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [Text(value[0]), Image.memory(value[4])],
        ),
      ),
    );
  }
}// END
