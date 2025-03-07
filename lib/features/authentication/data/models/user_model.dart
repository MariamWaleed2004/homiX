import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? name;
  final String? email;


  UserModel({
      this.uid,
      this.name,
      this.email,
      }) : super (
        uid: uid,
        name: name,
        email: email,

      );

    factory UserModel.fromSnapshot(DocumentSnapshot snap) {
      var snapshot = snap.data() as Map<String, dynamic>;

      return UserModel(
        uid: snapshot['uid'],
        name: snapshot['name'],
        email: snapshot['email'],
      );
    }



  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
  };


}