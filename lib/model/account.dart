class Accout{
  final String id;
  final String name;
  final String phone;
  final String password;
  

  Accout(
    {
      required this.id,
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