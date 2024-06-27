class UserModel {
  String? name;
  String? email;
  String? phone;
  String? token;
  String? image;

  // constructor
  UserModel(this.name, this.email, this.phone, this.token, this.image);

  // named constructor
  UserModel.fromJson({required Map<String, dynamic> data}) {
    //Refactoring map | Json
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    image = data["image"];
    token = data["token"];
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'image': image,
    };
  }

  
}
