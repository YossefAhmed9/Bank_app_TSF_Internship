class UserModel{
  int id;
  String name;
  String email;
  String age;
  int account;

  UserModel({required this.id,required this.name, required this.email, required this.age, required this.account});

  factory UserModel.fromJson(dynamic json,int index){
    var data=json[index];
    return UserModel(id: data['id'],name: data['name'],email:data['email'],age: data['age'],account: data['account']);
  }
}