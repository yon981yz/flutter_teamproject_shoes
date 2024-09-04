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
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  final data = snapshot.data!;
                                  List<DataRow> rows = data.map((shoes) {
                                    return DataRow(cells: [
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

              // 브랜드별 매출

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 420,
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
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  final data = snapshot.data!;
                                  List<DataRow> rows = data.map((brand) {
                                    return DataRow(cells: [
                                      DataCell(Text(brand.brand.toString())),
                                      DataCell(Text(brand.totalSales.toString()))
                                    ]);
                                  }).toList();
                                  return DataTable(
                                    columns: const [
                                      DataColumn(label: Text('브랜드 명')),
                                      DataColumn(label: Text('총 매출')),
                                    ],
                                    rows: rows,
                                  );
                                } else {
                                  return DataTable(
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


              // 최근 주문내역


                  Container(
                    height: 420,
                    width: 620,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0))),
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
                                if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  final data = snapshot.data!;
                                  List<DataRow> rows = data.map((account) {
                                    return DataRow(cells: [
                                      DataCell(Text(account.accountId.toString())),
                                      DataCell(Text(account.accountName)),
                                      DataCell(Text(account.purchaseCount.toString())),
                                      DataCell(Text(account.totalSales.toString())),
                                    ]);
                                  }).toList();
                                  return DataTable(
                                    columns: const [
                                      DataColumn(label: Text('주문번호')),
                                      DataColumn(label: Text('주문자명')),
                                      DataColumn(label: Text('주문수')),
                                      DataColumn(label: Text('전체 매출')),
                                    ],
                                    rows: rows,
                                  );
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
