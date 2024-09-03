class Account{
  final String id;
  final String name;
  final String phone;
  final String password;
  

  Account(
    {
      required this.id,
      required this.name,
      required this.phone,
      required this.password,
    }
  );

  Account.fromMap(Map<String, dynamic> acs)
  : id = acs['id'],
  name = acs['name'],
  phone = acs['phone'],
  password = acs['password'];
  
}