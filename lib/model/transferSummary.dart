class Transfersummary {
  final int? id;
  final String date;
  final String collectionstatus;
  final int shoesid;
  final String branchname;
  final String shoesname;
  final int branchid;


  Transfersummary({
    this.id,
    required this.date,
    required this.collectionstatus,
    required this.shoesid,
    required this.branchname,
    required this.shoesname,
    required this.branchid,
  });

  Transfersummary.fromMap(Map<String, dynamic> tfs)
    : id = tfs['id'],
      date = tfs['date'],
      collectionstatus = tfs['collectionstatus'],
      shoesid = tfs['shoesid'],
      branchname = tfs['branchname'],
      shoesname = tfs['shoesname'],
      branchid = tfs['branchid'];
}