class Transfersummary {
  final int? id;
  final String date;
  final String collection;
  final int shoesid;
  final String branchname;
  final String shoesname;


  Transfersummary({
    this.id,
    required this.date,
    required this.collection,
    required this.shoesid,
    required this.branchname,
    required this.shoesname,
  });

  Transfersummary.fromMap(Map<String, dynamic> tfs)
    : id = tfs['id'],
      date = tfs['date'],
      collection = tfs['collection'],
      shoesid = tfs['shoesid'],
      branchname = tfs['branchname'],
      shoesname = tfs['shoesname'];
}