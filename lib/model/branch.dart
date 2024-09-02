// 지점
class Branch {
  final int? id; // 지점번호
  final String address; // 지점주소

  Branch(
    {
      this.id,
      required this.address
    }
  );

  Branch.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  address = res['address'];
}