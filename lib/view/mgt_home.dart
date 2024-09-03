import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/view/mgt_order_search.dart';
import 'package:flutter_teamproject_shoes/view/mgt_product_mgt.dart';
import 'package:flutter_teamproject_shoes/view/mgt_statistic.dart';
import 'package:flutter_teamproject_shoes/view/mgt_transfer_mgt.dart';
import 'package:flutter_teamproject_shoes/view/test.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';
import 'package:get/route_manager.dart';

class MgtHome extends StatefulWidget {
  const MgtHome({super.key});

  @override
  State<MgtHome> createState() => _MgtHomeState();
}

class _MgtHomeState extends State<MgtHome> {
  late MgtHandler mgtHandler;

  @override
  void initState() {
    mgtHandler = MgtHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.home)),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
////// 이번달 매출현황
                      Container(
                        height: 270,
                        width: 590,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('images/Rectangle.png'),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('이번달 매출현황'),
                                )
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 500,
                                child: FutureBuilder(
                                  future: mgtHandler.querySalesMonth(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      return DataTable(columns: const [
                                        DataColumn(label: Text('총 구매')),
                                        DataColumn(label: Text('총 매출')),
                                      ], rows: [
                                        DataRow(cells: [
                                          DataCell(Text(snapshot.data![0].count
                                              .toString())),
                                          DataCell(Text(snapshot.data![0].total
                                              .toString())),
                                        ])
                                      ]);
                                    } else {
                                      return DataTable(
                                        dividerThickness: 1,
                                        // dataRowColor: const Color.fromARGB(255, 238, 238, 238),
                                        columns: const [
                                          DataColumn(
                                            label: Text('총 구매'),
                                          ),
                                          DataColumn(label: Text('총 매출')),
                                        ],
                                        rows: const [
                                          DataRow(cells: [
                                            DataCell(Text('0')),
                                            DataCell(Text('0')),
                                          ]),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ////// 오늘의 매출현황

                      Container(
                        height: 270,
                        width: 590,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('images/Rectangle.png'),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('오늘의 매출현황'),
                                )
                              ],
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 500,
                                child: FutureBuilder(
                                  future: mgtHandler.querySalesToday(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      return DataTable(columns: const [
                                        DataColumn(label: Text('총 구매')),
                                        DataColumn(label: Text('총 매출')),
                                      ], rows: [
                                        DataRow(cells: [
                                          DataCell(Text(
                                            snapshot.data![0].count.toString(),
                                          )),
                                          DataCell(Text(snapshot.data![0].total
                                              .toString())),
                                        ])
                                      ]);
                                    } else {
                                      return DataTable(
                                        // dataRowColor: const Color.fromARGB(255, 238, 238, 238),
                                        columns: const [
                                          DataColumn(
                                            label: Text('총 구매'),
                                          ),
                                          DataColumn(label: Text('총 매출')),
                                        ],
                                        rows: const [
                                          DataRow(cells: [
                                            DataCell(Text('0')),
                                            DataCell(Text('0')),
                                          ]),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ////// 이번달 Top 5 매출 상품

                  Container(
                    height: 560,
                    width: 590,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('images/Rectangle.png'),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('이번달 Top 5 매출 상품'),
                            )
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: FutureBuilder(
                              future: mgtHandler.queryTopFiveShoes(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  final data = snapshot.data!;
                                  List<DataRow> rows = data.map((shoes) {
                                    return DataRow(cells: [
                                      DataCell(Image.memory(
                                        shoes.image,
                                        width: 100,
                                        height: 50,
                                      )),
                                      DataCell(
                                          Text(shoes.shoesname.toString())),
                                      DataCell(
                                          Text(shoes.shoesbrand.toString())),
                                      DataCell(
                                          Text(shoes.totalOrder.toString())),
                                      DataCell(
                                          Text(shoes.totalsales.toString())),
                                    ]);
                                  }).toList();
                                  return DataTable(
                                    columns: const [
                                      DataColumn(label: Text('이미지')),
                                      DataColumn(label: Text('상품명')),
                                      DataColumn(label: Text('제조사')),
                                      DataColumn(label: Text('주문수')),
                                      DataColumn(label: Text('총 매출액')),
                                    ],
                                    rows: rows,
                                  );
                                } else {
                                  return DataTable(
                                    columns: const [
                                      DataColumn(label: Text('이미지')),
                                      DataColumn(label: Text('상품번호')),
                                      DataColumn(label: Text('상품명')),
                                      DataColumn(label: Text('제조사')),
                                      DataColumn(label: Text('주문수')),
                                      DataColumn(label: Text('총 매출액')),
                                    ],
                                    rows: const [
                                      DataRow(cells: [
                                        DataCell(Text('')),
                                        DataCell(Text('')),
                                        DataCell(Text('')),
                                        DataCell(Text('')),
                                        DataCell(Text('')),
                                        DataCell(Text('')),
                                      ]),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 최근 주문내역

              Container(
                height: 300,
                width: 1200,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromARGB(255, 0, 0, 0))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/Rectangle.png'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('최근 주문내역'),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 1200,
                      child: FutureBuilder(
                        future: mgtHandler.queryPurchaseDetails2Limit(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            final data = snapshot.data!;
                            List<DataRow> rows = data.map((purchase) {
                              return DataRow(cells: [
                                DataCell(Text(purchase.id.toString())),
                                DataCell(Text(purchase.accountName)),
                                DataCell(Text(purchase.accountPhone)),
                                DataCell(Text(purchase.salesprice.toString())),
                                DataCell(Text(purchase.purchasedate.toString())),
                                DataCell(Text(purchase.collectiondate.toString())),
                                DataCell(Text(purchase.collectionstatus)),
                              ]);
                            }).toList();
                            return DataTable(
                              columns: const [
                                DataColumn(label: Text('주문번호')),
                                DataColumn(label: Text('주문자명')),
                                DataColumn(label: Text('전화번호')),
                                DataColumn(label: Text('주문액')),
                                DataColumn(label: Text('주문일')),
                                DataColumn(label: Text('수령일')),
                                DataColumn(label: Text('수령여부')),
                              ],
                              rows: rows,
                            );
                          } else {
                            return DataTable(
                              columns: const [
                                DataColumn(label: Text('주문번호')),
                                DataColumn(label: Text('주문자명')),
                                DataColumn(label: Text('전화번호')),
                                DataColumn(label: Text('주문액')),
                                DataColumn(label: Text('주문일')),
                                DataColumn(label: Text('수령일')),
                                DataColumn(label: Text('수령여부')),
                              ],
                              rows: const [
                                DataRow(cells: [
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                ]),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 100, 0, 20),
              child: Text('관리자님 환영합니다'),
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(
                Icons.show_chart,
                color: Colors.black,
              ),
              title: const Text('매출 현황'),
              onTap: () {
                Get.back();
                Get.to(() => const MgtStatistic());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.inventory_2,
                color: Colors.black,
              ),
              title: const Text('재고 및 상품 관리'),
              onTap: () {
                Get.back();
                Get.to(() => const MgtProductMgt());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.manage_search,
                color: Colors.black,
              ),
              title: const Text('주문 및 수령 검색'),
              onTap: () {
                Get.back();
                Get.to(() => const MgtOrderSearch());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.approval,
                color: Colors.black,
              ),
              title: const Text('재고 수령 확인'),
              onTap: () {
                Get.back();
                Get.to(() => const MgtTransferMgt());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const Test())!.then((value) => reloadData());
        },
      ),
    );
  }

  reloadData() {
    setState(() {});
  }
}
