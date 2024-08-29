class Transfer {
      final int? id;
  final String date;
  final String collection;

  Transfer(
    {
      this.id,
      required this.date,
      required this.collection,
      
    }
  );

  Transfer.fromMap(Map<String, dynamic> tfs)
  : id = tfs['id'],
  date = tfs['date'],
  collection = tfs['collection'];
}