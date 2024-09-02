import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_teamproject_shoes/view/mgt_order_search.dart';
import 'package:flutter_teamproject_shoes/view/mgt_product_mgt.dart';
import 'package:flutter_teamproject_shoes/view/mgt_statistic.dart';
import 'package:flutter_teamproject_shoes/view/mgt_transferApproval.dart';
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
      appBar: AppBar(),
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
                        height: 250,
                        width: 600,
                        margin: const EdgeInsets.all(30.0),
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
                            SizedBox(
                              width: 250,
                              child: FutureBuilder(
                                future: mgtHandler.querySalesToday(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
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
                          ],
                        ),
                      ),

                      ////// 오늘의 매출현황

                      Container(
                        height: 250,
                        width: 600,
                        margin: const EdgeInsets.all(30.0),
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
                                    if (snapshot.hasData) {
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
                    width: 600,
                    margin: const EdgeInsets.all(30.0),
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
                            width: 250,
                            child: FutureBuilder(
                              future: mgtHandler.queryTopFiveShoes(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return DataTable(columns: const [
                                    DataColumn(label: Text('이미지')),
                                    DataColumn(label: Text('상품번호')),
                                    DataColumn(label: Text('상품명')),
                                    DataColumn(label: Text('제조사')),
                                    DataColumn(label: Text('주문수')),
                                    DataColumn(label: Text('총 매출액')),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Text(
                                          snapshot.data![0].image.toString())),
                                      DataCell(Text(snapshot.data![0].shoesid
                                          .toString())),
                                      DataCell(Text(snapshot.data![0].shoesname
                                          .toString())),
                                      DataCell(Text(snapshot.data![0].shoesbrand
                                          .toString())),
                                      DataCell(Text(snapshot.data![0].totalOrder
                                          .toString())),
                                      DataCell(Text(snapshot.data![0].totalsales
                                          .toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                          snapshot.data![1].image.toString())),
                                      DataCell(Text(snapshot.data![1].shoesid
                                          .toString())),
                                      DataCell(Text(snapshot.data![1].shoesname
                                          .toString())),
                                      DataCell(Text(snapshot.data![1].shoesbrand
                                          .toString())),
                                      DataCell(Text(snapshot.data![1].totalOrder
                                          .toString())),
                                      DataCell(Text(snapshot.data![1].totalsales
                                          .toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                          snapshot.data![2].image.toString())),
                                      DataCell(Text(snapshot.data![2].shoesid
                                          .toString())),
                                      DataCell(Text(snapshot.data![2].shoesname
                                          .toString())),
                                      DataCell(Text(snapshot.data![2].shoesbrand
                                          .toString())),
                                      DataCell(Text(snapshot.data![2].totalOrder
                                          .toString())),
                                      DataCell(Text(snapshot.data![2].totalsales
                                          .toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                          snapshot.data![3].image.toString())),
                                      DataCell(Text(snapshot.data![3].shoesid
                                          .toString())),
                                      DataCell(Text(snapshot.data![3].shoesname
                                          .toString())),
                                      DataCell(Text(snapshot.data![3].shoesbrand
                                          .toString())),
                                      DataCell(Text(snapshot.data![3].totalOrder
                                          .toString())),
                                      DataCell(Text(snapshot.data![3].totalsales
                                          .toString())),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                          snapshot.data![4].image.toString())),
                                      DataCell(Text(snapshot.data![4].shoesid
                                          .toString())),
                                      DataCell(Text(snapshot.data![4].shoesname
                                          .toString())),
                                      DataCell(Text(snapshot.data![4].shoesbrand
                                          .toString())),
                                      DataCell(Text(snapshot.data![4].totalOrder
                                          .toString())),
                                      DataCell(Text(snapshot.data![4].totalsales
                                          .toString())),
                                    ]),
                                  ]);
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
                                      DataRow(cells: [
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      ]),
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
                height: 200,
                width: 1265,
                margin: const EdgeInsets.all(30.0),
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
                      width: 250,
                      child: FutureBuilder(
                        future: mgtHandler.queryPurchaseDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return DataTable(columns: const [
                            DataColumn(label: Text('주문번호')),
                            DataColumn(label: Text('주문자명')),
                            DataColumn(label: Text('전화번호')),
                            DataColumn(label: Text('주문액')),
                            DataColumn(label: Text('주문일')),
                            DataColumn(label: Text('수령일')),
                            DataColumn(label: Text('수령여부')),
                          ], rows: [
                              DataRow(cells: [
                            DataCell(Text(snapshot.data![0].id.toString())),
                            DataCell(Text(snapshot.data![0].accountName)),
                            DataCell(Text(snapshot.data![0].accountPhone)),
                            DataCell(Text(snapshot.data![0].salesprice.toString())),
                            DataCell(Text(snapshot.data![0].purchasedate.toString())),
                            DataCell(Text(snapshot.data![0].collectiondate.toString())),
                            DataCell(Text(snapshot.data![0].collectionstatus)),
                          ]),
                              DataRow(cells: [
                            DataCell(Text(snapshot.data![1].id.toString())),
                            DataCell(Text(snapshot.data![1].accountName)),
                            DataCell(Text(snapshot.data![1].accountPhone)),
                            DataCell(Text(snapshot.data![1].salesprice.toString())),
                            DataCell(Text(snapshot.data![1].purchasedate.toString())),
                            DataCell(Text(snapshot.data![1].collectiondate.toString())),
                            DataCell(Text(snapshot.data![1].collectionstatus)),
                          ]),
                            ]);
                          } else {
                            return DataTable(
                              dividerThickness: 1,
                              // dataRowColor: const Color.fromARGB(255, 238, 238, 238),
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
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
                                  DataCell(Text('0')),
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
                Get.to(() => const MgtTransferapproval());
              },
            ),
          ],
        ),
      ),
    );
  }
}
