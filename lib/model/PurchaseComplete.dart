class PurchaseComplete{
  final int id;
  final String branch;
  
  PurchaseComplete(
    {
      required this.id,
      required this.branch,
    }
  );

  factory PurchaseComplete.fromMap(Map<String, dynamic> acs){
    return PurchaseComplete(
      id: acs['id'] , 
      branch: acs['name']
      );
  }
  // : id = acs['id'],
  // branch = acs['branch'];
  
}// done