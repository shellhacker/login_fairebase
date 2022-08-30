class UserModel{
String id;
final String?firstName;
final String? lastName;
final String? age;
final String? email;
final String? image;

  UserModel({ this.firstName,  this.lastName, this.age, this.email,this.image,this.id=''});


  Map<String,dynamic>toJson()=>{
    'uid':id,
    'first_name':firstName,
    'last_name':lastName,
    'age':age,
    'email':email,
    'image' :image
  };


  factory UserModel.fromJson(Map<String,dynamic>json){
    return
    UserModel(id: json['uid'],firstName: json['first_name'],
     lastName: json['last_name'], age: json['age'], email: json['email'],image: json['image']);

  }


}