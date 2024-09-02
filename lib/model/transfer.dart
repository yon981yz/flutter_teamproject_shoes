class Transfer {
  final int? id;
  final String date;
  final String collectionstatus;
  final int shoesid;
  final int branchid;

  Transfer({
    this.id,
    required this.date,
    required this.collectionstatus,
    required this.shoesid,
    required this.branchid,
  });

  Transfer.fromMap(Map<String, dynamic> tfs)
    : id = tfs['id'],
      date = tfs['date'],
      collectionstatus = tfs['collectionstatus'],
      shoesid = tfs['shoesid'],
      branchid = tfs['branchid'];
}