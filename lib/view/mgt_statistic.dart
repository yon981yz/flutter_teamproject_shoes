import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/vm/mgt_handler.dart';

class MgtStatistic extends StatefulWidget {
  const MgtStatistic({super.key});

  @override
  State<MgtStatistic> createState() => _MgtStatisticState();
}

class _MgtStatisticState extends State<MgtStatistic> {
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
                        height: 200,
                        width: 620,
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
                            ),
                          ],
                        ),
                      ),

                      ////// 오늘의 매출현황

                      Container(
                        height: 200,
                        width: 620,
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
                    height: 420,
                    width: 620,
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
                                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  return DataTable(columns: const [
                                    DataColumn(label: Text('이미지')),
                                    DataColumn(label: Text('상품번호')),
                                    DataColumn(label: Text('상품명')),
                                    DataColumn(label: Text('제조사')),
                                    DataColumn(label: Text('주문수')),
                                    DataColumn(label: Text('총 매출액')),
                                  ], rows: [
                                    DataRow(cells: [
                                      DataCell(Image.memory(
                                        snapshot.data![0].image,
                                        width: 100,
                                        height: 50,
                                      )),
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
                                      DataCell(Image.memory(
                                        snapshot.data![1].image,
                                        width: 100,
                                        height: 50,
                                      )),
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
                                      DataCell(Image.memory(
                                        snapshot.data![2].image,
                                        width: 100,
                                        height: 50,
                                      )),
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
                                      DataCell(Image.memory(
                                        snapshot.data![3].image,
                                        width: 100,
                                        height: 50,
                                      )),
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
                                      DataCell(Image.memory(
                                        snapshot.data![4].image,
                                        width: 100,
                                        height: 50,
                                      )),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 420,
                    width: 620,
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
                              child: Text('브랜드별 매출'),
                            )
                          ],
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 500,
                            child: FutureBuilder(
                              future: mgtHandler.querySalesBrand(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  return DataTable(columns: const [
                                  DataColumn(label: Text('브랜드 명')),
                                  DataColumn(label: Text('총 매출')),
                                ], rows: [
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![0].brand.toString())),
                                  DataCell(Text(snapshot.data![0].totalSales.toString())),
                                ]),
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![1].brand.toString())),
                                  DataCell(Text(snapshot.data![1].totalSales.toString())),
                                ]),
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![2].brand.toString())),
                                  DataCell(Text(snapshot.data![2].totalSales.toString())),
                                ]),
                                  ]);
                                } else {
                                  return DataTable(
                                    dividerThickness: 1,
                                    // dataRowColor: const Color.fromARGB(255, 238, 238, 238),
                                    columns: const [
                                  DataColumn(label: Text('브랜드 명')),
                                  DataColumn(label: Text('총 매출')),
                                    ],
                                    rows: const [
                                      DataRow(cells: [
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
                  Container(
                    height: 420,
                    width: 620,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: const Color.fromARGB(255, 0, 0, 0))),
                    child: Column(
                      children: [
                        Row(
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
                        Expanded(
                          child: SizedBox(
                            width: 500,
                            child: FutureBuilder(
                              future: mgtHandler.queryTopFiveAccount(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  return DataTable(columns: const [
                                  DataColumn(label: Text('주문번호')),
                                  DataColumn(label: Text('주문자명')),
                                  DataColumn(label: Text('주문수')),
                                  DataColumn(label: Text('전체 매출')),
                                ], rows: [
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![0].accountId.toString())),
                                  DataCell(Text(snapshot.data![0].accountName)),
                                  DataCell(Text(snapshot.data![0].purchaseCount.toString())),
                                  DataCell(Text(snapshot.data![0].totalSales.toString())),
                                ]),
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![1].accountId.toString())),
                                  DataCell(Text(snapshot.data![1].accountName)),
                                  DataCell(Text(snapshot.data![1].purchaseCount.toString())),
                                  DataCell(Text(snapshot.data![1].totalSales.toString())),
                                ]),
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![2].accountId.toString())),
                                  DataCell(Text(snapshot.data![2].accountName)),
                                  DataCell(Text(snapshot.data![2].purchaseCount.toString())),
                                  DataCell(Text(snapshot.data![2].totalSales.toString())),
                                ]),
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![3].accountId.toString())),
                                  DataCell(Text(snapshot.data![3].accountName)),
                                  DataCell(Text(snapshot.data![3].purchaseCount.toString())),
                                  DataCell(Text(snapshot.data![3].totalSales.toString())),
                                ]),
                                    DataRow(cells: [
                                  DataCell(Text(snapshot.data![4].accountId.toString())),
                                  DataCell(Text(snapshot.data![4].accountName)),
                                  DataCell(Text(snapshot.data![4].purchaseCount.toString())),
                                  DataCell(Text(snapshot.data![4].totalSales.toString())),
                                ]),
                                  ]);
                                } else {
                                  return DataTable(
                                    dividerThickness: 1,
                                    // dataRowColor: const Color.fromARGB(255, 238, 238, 238),
                                    columns: const [
                                  DataColumn(label: Text('주문번호')),
                                  DataColumn(label: Text('주문자명')),
                                  DataColumn(label: Text('주문수')),
                                  DataColumn(label: Text('전체 매출')),
                                    ],
                                    rows: const [
                                      DataRow(cells: [
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
            ],
          ),
        ),
      ),
    );
  }
}