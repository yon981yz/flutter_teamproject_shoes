// 지점
class Branch {
  final int? id; // 지점번호
  final String name; // 지점주소

  Branch(
    {
      this.id,
      required this.name
    }
  );

  Branch.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  name = res['name'];
}