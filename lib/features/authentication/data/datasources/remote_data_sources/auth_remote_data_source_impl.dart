import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:homix/features/authentication/data/models/user_model.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:homix/main.dart';
import 'package:homix/main_screen.dart';
import 'package:homix/navigatorKey.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:uuid/uuid.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDataSourceImpl({
    required this.firebaseFirestore,
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

      if (!userDoc.exists) {
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
  Future<void> signInUser(UserEntity user, BuildContext context) async {
    try {
      final methods =
          await firebaseAuth.fetchSignInMethodsForEmail(user.email!);
      if (methods.isEmpty) {
        _showIfAccountNotExistsDialog(context);
      } else {
        await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password") {
        print("errorrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user, BuildContext context) async {
    try {
      final methods =
          await firebaseAuth.fetchSignInMethodsForEmail(user.email!);
      if (methods.isNotEmpty) {
        _showIfAccountExistsDialog(context);
        return;
      } else {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );

        if (userCredential.user != null) {
          await createUser(user);

          try {
            await userCredential.user!.sendEmailVerification();
            Navigator.pushNamed(context, ScreenConst.verificationScreen);
          } catch (e) {
            toast("Failed to send verification email: $e");
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      toast('Something went wrong');

      //    if (e.code == 'email-already-in-use') {
      //    _showIfAccountExistsDialog;
      // } else {
      // }
    }
  }

  // @override
  // Future<void> signUpUser(UserEntity user) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;

  //   try {
  //     UserCredential userCredential =
  //         await firebaseAuth.createUserWithEmailAndPassword(
  //             email: user.email!, password: user.password!);

  //     if (userCredential.user != null) {

  //            await createUser(user); // Save user to Firestore

  //         try {
  //                 await userCredential.user!.sendEmailVerification();

  //             } catch (e) {
  //               toast("Failed to send verification email: $e");
  //             }

  //     }

  //   } on FirebaseAuthException catch (e) {
  // if (e.code == 'email-already-in-use') {
  //   toast("Email is already taken");
  // } else {
  //   toast('Something went wrong');
  // }
  //   }
  // }

  @override
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
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
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where('uid', isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    if (user.uid == null || user.uid!.isEmpty) {
      throw Exception("User UID is required to update user data");
    }

    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = {};

    if (user.name != '' && user.name != null)
      userInformation['name'] = user.name;

    try {
      await userCollection.doc(user.uid).update(userInformation);
      debugPrint("User data updated successfully");
    } catch (e) {
      debugPrint("Failed to update user: $e");
      throw Exception("Failed to update user data");
    }
  }

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// @override
// Future<UserCredential?> signInWithGoogle() async {
//   try {
//     print("🔄 Signing out previous sessions...");
//     await _googleSignIn.signOut();
//     await _auth.signOut();

//     try {
//       await _googleSignIn.disconnect();
//     } catch (e) {
//       print("⚠️ GoogleSignIn disconnect failed: $e");
//     }

//     print("🟢 Opening Google Sign-In...");
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       print("❌ User canceled Google Sign-In");
//       return null;
//     }

//     print("✅ Google Sign-In successful: ${googleUser.email}");

//     // Check if the account already exists in Firestore
//     print("🔍 Checking if account exists...");
//     bool accountExists = await _checkIfUserExists(googleUser.email);

//     if (accountExists) {
//       print("⚠️ Account already exists!");
//       _showAccountExistsDialog();
//       return null; // Stop the process if the account exists
//     }

//     // Proceed with Firebase sign-in if the account does not exist
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     final OAuthCredential credential = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//       accessToken: googleAuth.accessToken,
//     );

//     print("🔄 Signing in with Firebase...");
//     final UserCredential userCredential = await _auth.signInWithCredential(credential);
//     final User? user = userCredential.user;

//     await Future.delayed(Duration(seconds: 2));

//     if (user != null) {
//       print("✅ Firebase Sign-In successful: ${user.uid}");
//       await _saveUserToFirestore(user); // Save the new user to Firestore
//     }

//     return userCredential;
//   } catch (e) {
//     print("❌ Error signing in with Google: $e");
//     toast("Something went wrong: ${e.toString()}");
//     return null;
//   }
// }

// @override
// Future<UserCredential?> signInWithGoogle() async {
//   try {
//     print("🔄 Signing out previous sessions...");
//     await _googleSignIn.signOut();
//     await _auth.signOut();

//     try {
//       await _googleSignIn.disconnect();
//     } catch (e) {
//       print("⚠️ GoogleSignIn disconnect failed: $e");
//     }

//     print("🟢 Opening Google Sign-In...");
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       print("❌ User canceled Google Sign-In");
//       return null;
//     }

//     print("✅ Google Sign-In successful: ${googleUser.email}");

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     final OAuthCredential credential = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//       accessToken: googleAuth.accessToken,
//     );

//     print("🔍 Checking if account exists...");
//     bool accountExists = await _checkIfUserExists(googleUser.email);

//     if (accountExists) {
//       print("⚠️ Account already exists!");
//       toast("Account already exists. Please log in instead.");
//       return null;
//     }

//     print("🔄 Signing in with Firebase...");
//     final UserCredential userCredential = await _auth.signInWithCredential(credential);
//     final User? user = userCredential.user;

//     await Future.delayed(Duration(seconds: 2));

//     if (user != null) {
//       print("✅ Firebase Sign-In successful: ${user.uid}");
//       await _saveUserToFirestore(user);
//     }

//     return userCredential;
//   } catch (e) {
//     print("❌ Error signing in with Google: $e");
//     toast("Something went wrong: ${e.toString()}");
//     return null;
//   }
// }

  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<UserCredential?> signUpWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();

      try {
        await _googleSignIn.disconnect();
      } catch (e) {
        print("GoogleSignIn disconnect failed: $e");
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User canceled the login
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      bool accountExists = await _checkIfUserExists(googleUser.email);
      if (accountExists) {
        _showIfAccountExistsDialog(context);
        return null;
      }

      // Sign in the user with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user);
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => MainScreen(uid: user!.uid)));

      return userCredential;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  Future<bool> _checkIfUserExists(String? email) async {
    if (email == null) return false;

    print("11111111111111111Checking if user exists: $email");

    if (FirebaseAuth.instance.currentUser != null) {
      print("User is signed in: ${FirebaseAuth.instance.currentUser!.uid}");
    } else {
      print("No user is signed in!");
    }

    var querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        // .limit(1)
        .get();

    bool exists = querySnapshot.docs.isNotEmpty;
    print('User exists: $exists');

    return exists;
  }

//   Future<bool> _checkIfUserExists(String? email) async {
//   if (email == null) return false;

//   print("Checking if user exists: $email");

//   if (_auth.currentUser != null) {
//     print("User is signed in: ${_auth.currentUser!.uid}");
//   } else {
//     print("No user is signed in!");
//   }

//   try {
//     var querySnapshot = await _firestore
//         .collection('users')
//         .where('email', isEqualTo: email)
//         .limit(1)
//         .get();

//     bool exists = querySnapshot.docs.isNotEmpty;
//     print('User exists: $exists');

//     return exists;
//   } catch (e) {
//     print("Error querying Firestore: $e");
//     return false;
//   }
// }

  void _showIfAccountExistsDialog(BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  "Account already exist, Please log in instead.",
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          ),
        ));
  }

  void _showIfAccountNotExistsDialog(BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  "Account doesn't exist, Please sign up instead.",
                  style: TextStyle(color: Colors.white),
                ))
              ],
            ),
          ),
        ));
  }

  //   void _showIfAccountNotExistsDialog() {
  //   showDialog(
  //     context: navigatorKey.currentState!.overlay!.context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Sign in failed"),
  //         content:
  //             Text("Account doesn't exists. Please sign up instead."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               "Okay",
  //               style: TextStyle(
  //                 color: Colors.black
  //               ),
  //               ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _saveUserToFirestore(User user) async {
    final userDoc =
        firebaseFirestore.collection(FirebaseConst.users).doc(user.uid);

    final docSnapshot = await userDoc.get();

    // Only add user if they don't already exist
    if (!docSnapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'name': user.displayName ?? "No Name",
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    if (!(user.emailVerified)) {
      await user.sendEmailVerification();
      print("Verification email sent to ${user.email}");
    } else {
      print("Account is verified");
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();

      try {
        await _googleSignIn.disconnect();
      } catch (e) {
        print("GoogleSignIn disconnect failed: $e");
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User canceled the login
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      bool accountExists = await _checkIfUserExists(googleUser.email);
      if (!accountExists) {
        _showIfAccountNotExistsDialog(context);
        return null;
      }

      // Sign in the user with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user);
      }

      return userCredential;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }
}
