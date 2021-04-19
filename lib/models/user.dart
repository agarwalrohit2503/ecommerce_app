import 'package:cloud_firestore/cloud_firestore.dart';

class UserModal {
  String email;
  String userId;

  UserModal({
    this.email,
    this.userId,
  });
//List - > Array
//Map  = > json
  factory UserModal.fromJson(Map data) {
    return UserModal(
      email: data['email_address'],
      userId: data['user_id'],
    );
  }

  //toJson
  //fromJson

}
