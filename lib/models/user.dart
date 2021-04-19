class User {
  String name;
  String email;
  int userId;

  User({
    this.email,
    this.name,
    this.userId,
  });
//List - > Array
//Map  = > json
  factory User.fromJson(Map data) {
    return User(
      email: data['email'],
      name: data['name'],
      userId: data['userId'],
    );
  }

  //toJson
  //fromJson

}
