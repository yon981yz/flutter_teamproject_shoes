import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/view/user_my_info.dart';
import 'package:flutter_teamproject_shoes/view/user_product_details.dart';
import 'package:flutter_teamproject_shoes/view/user_purchase_list.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late TextEditingController searchController;
  late List<int> sizes;
  late int sizeValue;
  late int kindChoice;
  late CustomerHandler handler;
  late List<Shoes> shoesList;
  late String ? brand;
    late Future<List<Shoes>> searchFutureNike;  
    late Future<List<Shoes>> searchFutureNew;  
    late Future<List<Shoes>> searchFuturePro;
    late Future<List<Shoes>> searchFutureAll;
  // Shoes? selectedShoe;

    late String userId;
    final box = GetStorage();

  //Segment Widget
  Map<int, Image> segmentWidgets = {
    0: Image.asset('images/all.png', width: 70,),
    1: Image.asset('images/nike.png', width: 70,),
    2: Image.asset('images/newbalance.png', width: 80,),
    3: Image.asset('images/prospecs.png', width: 90,)
  };

  @override
  void initState() {
    super.initState();
    kindChoice=0;
    handler=CustomerHandler();
    searchController = TextEditingController();
    sizes=[230];
    sizeValue= sizes.isNotEmpty ? sizes.first : 230;
    loadShoes();
    searchFutureNike = Future.value([]);    
    searchFutureNew = Future.value([]);    
    searchFuturePro = Future.value([]);
    searchFutureAll=Future.value([]);
    brand='';
    // handler.queryShoesSize();
    userId = "";
    iniStorage();
  }

  iniStorage() {
    userId = box.read('p_userID');
  }

  Future loadShoes() async{
    shoesList=await handler.queryShoesHome();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              drawer: Drawer(
          child: ListView(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userId,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '님',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'SB Mart에 오신 것을 \n     환영 합니다!',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        onTap: () {
                          Get.back();
                          Get.to(
                            () => const UserMyInfo(),
                          );
                        },
                        title: const Text('내정보'),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        onTap: () {
                          Get.back();
                          Get.to(
                            () => const UserPurchaseList(),
                          );
                        },
                        title: const Text('구매내역'),
                      ),
                      const Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      appBar: AppBar(
        title: const Column(children: [
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
        backgroundColor: const Color(0xFFCFD2A5),
      ),                                                                                                     
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: 400,
                color: const Color(0xFFCFD2A5),
                child: Column( children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              width: 370,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFDADADA),
                                  borderRadius: BorderRadius.circular(20)),
                              child: 
                              Row(children: [
                                SizedBox(
                                  width: 320,
                                  child: SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(22, 0, 0, 0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: TextField(
                                          controller: searchController,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      searchAction();
                                    },
                                    icon: const Icon(Icons.search)),
                              ]),
                            ),
                          ),
            CupertinoSegmentedControl(
              children: segmentWidgets, 
              onValueChanged: (value) {
                kindChoice=value;
                if(kindChoice==0){
                  handler.queryShoesHome();
                }else if(kindChoice==1){
                  handler.queryNike();
                }
                else if(kindChoice==2){
                  handler.queryNewBalance();
                }
                else{
                  handler.queryProSpecs();
                }setState(() {
                });
              },
              ),
                ]
          ),
              ),
              kindChoice==1&&searchController.text.trim().isEmpty
              ?
              SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: handler.queryNike(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                          ), 
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: handler.queryShoesSize(snapshot.data![index].image),
                            builder: (context, shot) {
                            return Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const UserProductDetails(),
                                      arguments: [
                                        snapshot.data![index].name,
                                        snapshot.data![index].size,
                                        snapshot.data![index].color,
                                        snapshot.data![index].salesprice,
                                        snapshot.data![index].image,
                                        snapshot.data![index].logo,
                                        snapshot.data![index].brand,
                                      ]
                                      );
                                    },
                                    child: Image.memory(snapshot.data![index].image, width: 130,)),
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data![index].logo, width: 40,),
                                      Text(snapshot.data![index].name,
                                      overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('  ${snapshot.data![index].salesprice.toString()} 원')
                                    ],
                                  ),
                                  Expanded(
                                    child: DropdownButton<int>(
                                      dropdownColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      isExpanded: true,                                      
                                      value: sizeValue,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: shot.data?.map((int size){
                                        return DropdownMenuItem<int>(
                                          value: size,
                                          child: Text(size.toString())
                                          );
                                      }
                                      ).toList(), 
                                      onChanged: (value) {
                                        // sizeValue=value!;
                                        if(value!=null){
                                          setState(() {
                                            sizeValue=value;
                                          });
                                        }
                                        handler.querySelectshoe(snapshot.data![index].image, sizeValue);
                                        Get.to(()=>const UserProductDetails(),
                                        arguments: [
                                          snapshot.data![index].name,
                                          value,
                                          snapshot.data![index].color,
                                          snapshot.data![index].salesprice,
                                          snapshot.data![index].image,
                                          snapshot.data![index].logo,
                                          snapshot.data![index].brand,
                                          snapshot.data![index].id,
                                        ]
                                        );                                  
                                        setState(() {});
                                      },
                                      ),
                                  ),
                                ],
                              ),
                            );
                            }
                          );
                        },
                        );
                    }else{
                      return const Center(
                        child: Text('목록이 없습니다.'),
                      );
                    }
                  },
                  ),
              )
              : kindChoice==2&&searchController.text.trim().isEmpty
              ?
              SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: handler.queryNewBalance(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                          ), 
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: handler.queryShoesSize(snapshot.data![index].image),
                            builder: (context, shot) {
                              return Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const UserProductDetails(),
                                      arguments: [
                                        snapshot.data![index].name,
                                        snapshot.data![index].size,
                                        snapshot.data![index].color,
                                        snapshot.data![index].salesprice,
                                        snapshot.data![index].image,
                                        snapshot.data![index].logo,
                                        snapshot.data![index].brand,
                                      ]
                                      );
                                    },
                                    child: Image.memory(snapshot.data![index].image, width: 130,)),
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data![index].logo, width: 40,),
                                      Text(snapshot.data![index].name,
                                      overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('  ${snapshot.data![index].salesprice.toString()} 원')
                                    ],
                                  ),
                                  Expanded(
                                    child: DropdownButton<int>(
                                      dropdownColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      isExpanded: true,                                      
                                      value: sizeValue,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: shot.data?.map((int size){
                                        return DropdownMenuItem(
                                          value: size,
                                          child: Text(size.toString())
                                          );
                                      }
                                      ).toList(), 
                                      onChanged: (value) {
                                        if(value!=null){
                                          setState(() {
                                            sizeValue=value;
                                          });
                                        }
                                        handler.querySelectshoe(snapshot.data![index].image, shot.data![index]);
                                        Get.to(()=>const UserProductDetails(),
                                        arguments: [
                                          snapshot.data![index].name,
                                          value,
                                          snapshot.data![index].color,
                                          snapshot.data![index].salesprice,
                                          snapshot.data![index].image,
                                          snapshot.data![index].logo,
                                          snapshot.data![index].brand,
                                          snapshot.data![index].id,
                                        ]
                                        );                                  
                                        setState(() {});
                                      },
                                      ),
                                  ),
                                ],
                              ),
                            );
                            },
                          );
                        },
                        );
                    }else{
                      return const Center(
                        child: Text('목록이 없습니다.'),
                      );
                    }
                  },
                  ),
              )
              : kindChoice==3&&searchController.text.trim().isEmpty
              ?
              SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: handler.queryProSpecs(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                          ), 
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: handler.queryShoesSize(snapshot.data![index].image),
                            builder: (context, shot) {
                              return Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const UserProductDetails(),
                                      arguments: [
                                        snapshot.data![index].name,
                                        snapshot.data![index].size,
                                        snapshot.data![index].color,
                                        snapshot.data![index].salesprice,
                                        snapshot.data![index].image,
                                        snapshot.data![index].logo,
                                        snapshot.data![index].brand,
                                      ]
                                      );
                                    },
                                    child: Image.memory(snapshot.data![index].image, width: 130,)),
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data![index].logo, width: 40,),
                                      Text(snapshot.data![index].name,
                                      overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('  ${snapshot.data![index].salesprice.toString()} 원')
                                    ],
                                  ),
                                  Expanded(
                                    child: DropdownButton(
                                      dropdownColor: Colors.white,
                                      isExpanded: true,
                                      value: sizeValue,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: shot.data?.map((int size){
                                        return DropdownMenuItem(
                                          value: size,
                                          child: Text(size.toString())
                                          );
                                      }
                                      ).toList(), 
                                      onChanged: (value) {
                                        if(value!=null){
                                          setState(() {
                                            sizeValue=value;
                                          });
                                        }
                                        handler.querySelectshoe(snapshot.data![index].image, sizeValue);
                                        Get.to(()=>const UserProductDetails(),
                                        arguments: [
                                          snapshot.data![index].name,
                                          value,
                                          snapshot.data![index].color,
                                          snapshot.data![index].salesprice,
                                          snapshot.data![index].image,
                                          snapshot.data![index].logo,
                                          snapshot.data![index].brand,
                                          snapshot.data![index].id,
                                        ]
                                        );                                  
                                        setState(() {});
                                      },
                                      ),
                                  ),
                                ],
                              ),
                            );
                            },
                          );
                        },
                        );
                    }else{
                      return const Center(
                        child: Text('목록이 없습니다.'),
                      );
                    }
                  },
                  ),
              )
              : kindChoice==0&&searchController.text.trim().isEmpty
              ? 
              SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: handler.queryShoesHome(), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                          ), 
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: handler.queryShoesSize(snapshot.data![index].image),
                            builder: (context, shot) {
                              if(shot.hasData){
                              return Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const UserProductDetails(),
                                      arguments: [
                                        snapshot.data![index].name,
                                        snapshot.data![index].size,
                                        snapshot.data![index].color,
                                        snapshot.data![index].salesprice,
                                        snapshot.data![index].image,
                                        snapshot.data![index].logo,
                                        snapshot.data![index].brand,
                                      ]
                                      );
                                    },
                                    child: Image.memory(snapshot.data![index].image, width: 130,)),
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data![index].logo, width: 40,),
                                      Text(snapshot.data![index].name,
                                      overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('  ${snapshot.data![index].salesprice.toString()} 원')
                                    ],
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 100,
                                      child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        isExpanded: true,
                                        value: sizeValue,
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        items: shot.data?.map((int size){
                                          return DropdownMenuItem<int>(
                                            value: size,
                                            child: Text(size.toString())
                                            );
                                        }
                                        ).toList(), 
                                        onChanged: (value) {
                                          if(value!=null){
                                            setState(() {
                                            sizeValue=value;
                                            });
                                          }
                                          handler.querySelectshoe(snapshot.data![index].image, sizeValue);
                                          Get.to(()=>const UserProductDetails(),
                                          arguments: [
                                            snapshot.data![index].name,
                                            value,
                                            snapshot.data![index].color,
                                            snapshot.data![index].salesprice,
                                            snapshot.data![index].image,
                                            snapshot.data![index].logo,
                                            snapshot.data![index].brand,
                                            snapshot.data![index].id,
                                          ]
                                          );                                  
                                          setState(() {});
                                        },
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                              }else{
                                return const Center(child: Text('No sizes available.'));
                              }
                            },
                          );
                        },
                        );
                    }else{
                      return const Center(
                        child: Text('목록이 없습니다.'),
                      );
                    }
                  },
                  ),
              )
              : kindChoice==0&&searchController.text.trim().isNotEmpty
              ?
              SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: handler.queryShoesHomeSearch(searchController.text.trim()), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                          ), 
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: handler.queryShoesSize(snapshot.data![index].image),
                            builder: (context, shot) {
                              return Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const UserProductDetails(),
                                      arguments: [
                                        snapshot.data![index].name,
                                        snapshot.data![index].size,
                                        snapshot.data![index].color,
                                        snapshot.data![index].salesprice,
                                        snapshot.data![index].image,
                                        snapshot.data![index].logo,
                                        snapshot.data![index].brand,
                                      ]
                                      );
                                    },
                                    child: Image.memory(snapshot.data![index].image, width: 130,)),
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data![index].logo, width: 40,),
                                      Text(snapshot.data![index].name,
                                      overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('  ${snapshot.data![index].salesprice.toString()} 원')
                                    ],
                                  ),
                                  Expanded(
                                    child: DropdownButton<int>(
                                      dropdownColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      isExpanded: true,                                      
                                      value: sizeValue,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: shot.data?.map((int size){
                                        return DropdownMenuItem<int>(
                                          value: size,
                                          child: Text(size.toString())
                                          );
                                      }
                                      ).toList(), 
                                      onChanged: (value) {
                                        if(value!=null){
                                            sizeValue=value;                                          
                                          setState(() {
                                          });
                                          value.toInt();
                                        }
                                        handler.querySelectshoe(snapshot.data![index].image, sizeValue);
                                        Get.to(()=>const UserProductDetails(),
                                        arguments: [
                                          snapshot.data![index].name,
                                          value,
                                          snapshot.data![index].color,
                                          snapshot.data![index].salesprice,
                                          snapshot.data![index].image,
                                          snapshot.data![index].logo,
                                          snapshot.data![index].brand,
                                          snapshot.data![index].id,
                                        ]
                                        );                                  
                                        setState(() {});
                                      },
                                      ),
                                  ),
                                ],
                              ),
                            );
                            },
                          );
                        },
                        );
                    }else{
                      return const Center(
                        child: Text('목록이 없습니다.'),
                      );
                    }
                  },
                  ),
              )            
              : SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: handler.queryBrandSearch(brand!,searchController.text.trim()), 
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                          ), 
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: handler.queryShoesSize(snapshot.data![index].image),
                            builder: (context, shot) {
                              return Container(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(()=>const UserProductDetails(),
                                      arguments: [
                                        snapshot.data![index].name,
                                        snapshot.data![index].size,
                                        snapshot.data![index].color,
                                        snapshot.data![index].salesprice,
                                        snapshot.data![index].image,
                                        snapshot.data![index].logo,
                                        snapshot.data![index].brand,
                                      ]
                                      );
                                    },
                                    child: Image.memory(snapshot.data![index].image, width: 130,)),
                                  Row(
                                    children: [
                                      Image.memory(snapshot.data![index].logo, width: 40,),
                                      Text(snapshot.data![index].name,
                                      overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('  ${snapshot.data![index].salesprice.toString()} 원')
                                    ],
                                  ),
                                  Expanded(
                                    child: DropdownButton(
                                      dropdownColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      isExpanded: true,                                      
                                      value: sizeValue,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: shot.data?.map((int size){
                                        return DropdownMenuItem<int>(
                                          value: size,
                                          child: Text(size.toString(),)
                                          );
                                      }
                                      ).toList(), 
                                      onChanged: (value) {
                                        if(value!=null){
                                          setState(() {
                                            sizeValue=value;
                                          });
                                        }
                                        handler.querySelectshoe(snapshot.data![index].image, sizeValue);
                                        Get.to(()=>const UserProductDetails(),
                                        arguments: [
                                          snapshot.data![index].name,
                                          value,
                                          snapshot.data![index].color,
                                          snapshot.data![index].salesprice,
                                          snapshot.data![index].image,
                                          snapshot.data![index].logo,
                                          snapshot.data![index].brand,
                                          snapshot.data![index].id,
                                        ]
                                        );                                  
                                        setState(() {});
                                      },
                                      ),
                                  ),
                                ],
                              ),
                                                          );
                            },
                          );
                        },
                        );
                    }else{
                      return const Center(
                        child: Text('목록이 없습니다.'),
                      );
                    }
                  },
                  ),
              )            
            ],
          ),
        ),
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
    );
  }
  searchAction(){
    if(kindChoice==1){
      brand='Nike';
      if (searchController.text.trim().isNotEmpty) {
        searchFutureNike = handler.queryBrandSearch(brand!,searchController.text.trim());
      } else {
        searchFutureNike = Future.value([]);
      }
    }else if(kindChoice==2){
      brand='NewBalance';
      if (searchController.text.trim().isNotEmpty) {
        searchFutureNew = handler.queryBrandSearch(brand!,searchController.text.trim());
      } else {
        searchFutureNew = Future.value([]);
      }
    }else if(kindChoice==3){
      brand='ProSpecs';
      if (searchController.text.trim().isNotEmpty) {
        searchFuturePro = handler.queryBrandSearch(brand!,searchController.text.trim());
      } else {
        searchFuturePro = Future.value([]);
      }
    }else if(kindChoice==0){
      if(searchController.text.trim().isNotEmpty){
        searchFutureAll=handler.queryShoesHomeSearch(searchController.text.trim());
      }else{
        searchFutureAll=Future.value([]);
      }
    }
    setState(() {});
  }

  reloadData(){
    setState(() {});
  }
}