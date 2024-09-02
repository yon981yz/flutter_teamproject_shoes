class Transfer {
  final int? id;
  final String date;
  final String collection;
  final int shoesid;
  final int branchid;

  Transfer({
    this.id,
    required this.date,
    required this.collection,
    required this.shoesid,
    required this.branchid,
  });

  Transfer.fromMap(Map<String, dynamic> tfs)
    : id = tfs['id'],
      date = tfs['date'],
      collection = tfs['collection'],
      shoesid = tfs['shoesid'],
      branchid = tfs['branchid'];
}