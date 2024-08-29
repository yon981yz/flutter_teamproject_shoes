class Accout{
  final int? id;
  final String name;
  final String phone;
  final String password;
  

  Accout(
    {
      this.id,
      required this.name,
      required this.phone,
      required this.password,
    }
  );

  Accout.fromMap(Map<String, dynamic> acs)
  : id = acs['id'],
  name = acs['name'],
  phone = acs['phone'],
  password = acs['password'];
  
}