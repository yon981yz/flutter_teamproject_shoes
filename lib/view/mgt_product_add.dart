import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

class MgtProductAdd extends StatefulWidget {
  const MgtProductAdd({super.key});

  @override
  State<MgtProductAdd> createState() => _MgtProductAddState();
}

class _MgtProductAddState extends State<MgtProductAdd> {
  late MgtHandler mgt_Handler;
  late TextEditingController nameController;
  late TextEditingController sizeController;
  late TextEditingController salespriceController;
  late TextEditingController colorController;
  late TextEditingController brandController;

    XFile? imageFile;
  final ImagePicker imagepicker = ImagePicker();
    XFile? logoFile;
  final ImagePicker logopicker = ImagePicker();

  @override
  void initState() {
    super.initState();

    mgt_Handler = MgtHandler();
    nameController = TextEditingController();
    sizeController = TextEditingController();
    salespriceController = TextEditingController();
    colorController = TextEditingController();
    brandController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                                  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                            onPressed: () {
                              getImageFromGallery(ImageSource.gallery);
                            },
                            child: const Text('이미지')),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey,
                        child: Center(
                          child: imageFile == null
                              ? const Text('이미지를 선택해주세요')
                              : Image.file(File(imageFile!.path)
                              ),
                        ),
                      ),
                                  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                            onPressed: () {
                              getlogoFromGallery(ImageSource.gallery);
                            },
                            child: const Text('브랜드 로고')),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey,
                        child: Center(
                          child: logoFile == null
                              ? const Text('브랜드 로고를 선택해주세요')
                              : Image.file(File(logoFile!.path)
                              ),
                        ),
                      ),
                ],
        
        
              ),
                      Column(
                        children: [
                              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            labelText: '품명을 입력해주세요'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: sizeController,
                        decoration:
                            const InputDecoration(labelText: '사이즈를 입력해주세요'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: salespriceController,
                        decoration: const InputDecoration(
                            labelText: '가격을 입력해주세요'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: colorController,
                        decoration: const InputDecoration(
                            labelText: '색상을 입력해주세요'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: brandController,
                        decoration: const InputDecoration(
                            labelText: '브랜드를 입력해주세요'),
                      ),
                    ),
                  ),
                        ],
                      ),
                ],
              ),
                            Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        insertAction();
                      },
                      child: const Text('입력'),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
  //Function
  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await imagepicker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = XFile(pickedFile.path);
      setState(() {});
    }
  }
  Future getlogoFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await logopicker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    } else {
      logoFile = XFile(pickedFile.path);
      setState(() {});
    }
  }

  Future insertAction() async {
    // File Type Byte Type으로 변환하기
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();
    File logoFile1 = File(logoFile!.path);
    Uint8List getlogo = await logoFile1.readAsBytes();

    var shoesInsert = Shoes(
        name: nameController.text.trim(),
        size: int.parse(sizeController.text.trim()),
        salesprice: int.parse(salespriceController.text.trim()),
        color: colorController.text.trim(),
        brand: brandController.text.trim(),
        image: getImage,
        logo: getlogo );
    int result = await mgt_Handler.insertShoes(shoesInsert);
    if(result != 0) {
      _showDialog();
    }
  }


  _showDialog(){
    Get.defaultDialog(
      title: 'input result',
      middleText: 'input complete',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          }, 
          child: const Text('ok')
        ),
      ]
    );
  }

}