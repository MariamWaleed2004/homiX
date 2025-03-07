import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:homix/features/authentication/data/models/user_model.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDataSourceImpl(
      {required this.firebaseFirestore, 
      required this.firebaseAuth,
      required this.firebaseStorage,
      });



  // Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
  //   final userCollection = firebaseFirestore.collection(FirebaseConst.users);

  //   final uid = await getCurrentUid();

  //   userCollection.doc(uid).get().then((userDoc) {
  //     final newUser = UserModel(
  //       uid: uid,
  //       name: user.name,
  //       email: user.email,
  //     ).toJson();

  //     if(!userDoc.exists) {
  //       userCollection.doc(uid).set(newUser);
  //     } else {
  //       userCollection.doc(uid).update(newUser);
  //     }

  //   }).catchError((error) {
  //     toast("some error occur");
  //   });
  // }


  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        name: user.name,
        email: user.email,
      ).toJson();

      if(!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }

    }).catchError((error) {
      toast("some error occur");
    });
  }



  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  


  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if(user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      } else {
        print("fields can't be empty");
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == "User-not-found") {
        toast("User not found");
      } else if (e.code == "wrong-password") {
        toast("Invalid email or password");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }


  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: user.password!).then((currentUser) async {
        if(currentUser.user?.uid != null) {
          await createUser(user);
      }
      });
      return;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use') {
        toast("email is already taken");
      } else {
        toast('something went wrong');
      }
    }
  }

 
  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async {

    final ref = FirebaseStorage.instance
    .ref()
    .child(childName)
    .child('${firebaseAuth.currentUser!.uid}.jpg');



    await ref.putFile(file!);
    final imageUrl = ref.getDownloadURL();

    return await imageUrl;
    
  }
  
  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where('uid', isEqualTo: uid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }
  
 @override
  Future<void> updateUser(UserEntity user) async {

    if(user.uid == null || user.uid!.isEmpty) {
      throw Exception("User UID is required to update user data");
    }

    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = {};

    if(user.name != '' && user.name != null) userInformation['name'] = user.name;

    try {
      await userCollection.doc(user.uid).update(userInformation);
      debugPrint("User data updated successfully");
    } catch (e) {
      debugPrint("Failed to update user: $e");
      throw Exception("Failed to update user data");
    }
       
    
  } 
  
}