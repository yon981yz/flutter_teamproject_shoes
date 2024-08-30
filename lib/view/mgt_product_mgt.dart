import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/model/shoes.dart';
import 'package:flutter_teamproject_shoes/view/mgt_product_add.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';
import 'package:flutter_teamproject_shoes/vm/kiosk_handler.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';

class MgtProductMgt extends StatefulWidget {
  const MgtProductMgt({super.key});

  @override
  State<MgtProductMgt> createState() => _MgtProductMgtState();
}

class _MgtProductMgtState extends State<MgtProductMgt> {

    late KioskHandler kioskHandler;
    late MgtHandler mgtHandler;
    late TextEditingController searchEditingController;
    late Future<List<Shoes>> searchFuture;
    late Future<List<Shoes>> searchFutureNike;
    late CustomerHandler customerHandler; 


  @override
  void initState() {
    super.initState();
    kioskHandler = KioskHandler();
    mgtHandler = MgtHandler();
    searchEditingController = TextEditingController();
    searchFuture = Future.value([]); 
    searchFutureNike = Future.value([]);
    customerHandler = CustomerHandler();
  }

  performSearch() {
    final searchText = searchEditingController.text.trim();
    if (searchText.isNotEmpty) {
      // Assuming the id is an integer
      final id = int.tryParse(searchText);
      if (id != null) {
        searchFuture = kioskHandler.queryTest(id);
        setState(() {});
      } else {
        // Handle invalid id input
        searchFuture = Future.value([]);
        setState(() {});
      }
    } else {
      // Handle empty search case
      searchFuture = Future.value([]);
      setState(() {});
    }
  }

  void performSearchNike() {
    final searchText = searchEditingController.text.trim();
      if (searchText.isNotEmpty) {
        searchFutureNike = customerHandler.queryNikeSearch(searchText);
      } else {
        searchFutureNike = Future.value([]);
      }
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('product mgt'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const MgtProductAdd())!
                  .then((value) => reloadData());
            },
            icon: 
              const Icon(Icons.add_outlined)
          )
        ],
      ),
      body: 
      
      SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: searchEditingController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      performSearchNike();
                    },
                    icon: const Icon(Icons.search)
                  ),
                ),
              ),

              searchEditingController.text.trim().isEmpty
              ? SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: customerHandler.queryShoesHome(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Image.memory(
                                  snapshot.data![index].image,
                                  width: 100,
                                ),
                                Text(snapshot.data![index].name)
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
              : SizedBox(
                height: 500,
                child: FutureBuilder<List<Shoes>>(
                  future: searchFutureNike,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              children: [
                                Image.memory(
                                  snapshot.data![index].image,
                                  width: 100,
                                ),
                                Text(snapshot.data![index].name)
                              ],
                            ),
                          );

                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )



             // search (등록번호)
            
            //   searchEditingController.text.trim().isEmpty
            //   ? SizedBox(
            //     height: 500,
            //     child: FutureBuilder(
            //       future: mgtHandler.queryShoes(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return ListView.builder(
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               return Card(
            //                 child: Row(
            //                   children: [
            //                     Image.memory(
            //                       snapshot.data![index].image,
            //                       width: 100,
            //                     ),
            //                     Text(snapshot.data![index].name)
            //                   ],
            //                 ),
            //               );
            //             },
            //           );
            //         } else {
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       },
            //     ),
            //   )
            // : SizedBox(
            //     height: 500,
            //     child: FutureBuilder<List<Shoes>>(
            //       future: searchFuture,
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return ListView.builder(
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               return Card(
            //                 child: Row(
            //                   children: [
            //                     Image.memory(
            //                       snapshot.data![index].image,
            //                       width: 100,
            //                     ),
            //                     Text(snapshot.data![index].name)
            //                   ],
            //                 ),
            //               );
            //             },
            //           );
            //         } else {
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         }
            //       },
            //     ),
            //   )

              
              // SizedBox(
              //   height: 500,
              //   child: FutureBuilder(
              //     future: mgtHandler.queryShoes(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return ListView.builder(
              //           itemCount: snapshot.data!.length,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               child: Row(
              //                 children: [
              //                   Image.memory(
              //                     snapshot.data![index].image,
              //                     width: 100,
              //                   ),
              //                   Text(snapshot.data![index].name)
              //                 ],
              //               ),
              //             );
              //           },
              //         );
              //       } else {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  reloadData() {
    setState(() {});
  }

}// END
