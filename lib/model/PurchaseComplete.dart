class PurchaseComplete{
  final int id;
  final String branch;
  
  PurchaseComplete(
    {
      required this.id,
      required this.branch,
    }
  );

  PurchaseComplete.fromMap(Map<String, dynamic> acs)
  : id = acs['id'],
  branch = acs['branch'];
  
}// done