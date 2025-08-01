import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/profile/presentation/widgets/profile_option_tile.dart';

class ProfileScreen extends StatefulWidget {
  final UserEntity currentUser;

  const ProfileScreen({super.key, required this.currentUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double width = AppSizes.screenWidth(context);
    double height = AppSizes.screenHeight(context);
    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text("Profile",
              style: TextStyle(
                fontSize: width * 0.055,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: height * 0.08),
          Container(
            height: width * 0.32,
            width: width * 0.32,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/profile_photo.webp"),
                  fit: BoxFit.cover,
                ),
                //color: const Color.fromARGB(255, 174, 42, 42),
                borderRadius: BorderRadius.circular(width * 0.16)),
          ),
          SizedBox(height: height * 0.02),
          Text("Olivia Bennett",
              //"${widget.currentUser.name}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 0.05,
              )),
          SizedBox(height: height * 0.001),
          Text("olivia.bennett92@gmail.com",
              //"${widget.currentUser.email}",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: width * 0.033,
              )),
          SizedBox(height: height * 0.02),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Text("Account Settings",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[600],
                  )),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              children: [
                ProfileOptionTile(
                  title: "Personal Information",
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenConst.personalInformationScreen);
                  },
                ),
                SizedBox(height: height * 0.02),
                ProfileOptionTile(
                  title: "Notifications",
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenConst.personalInformationScreen);
                  },
                ),
                SizedBox(height: height * 0.02),
                ProfileOptionTile(
                  title: "Following",
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenConst.personalInformationScreen);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Text("Help & Support",
                  style: TextStyle(
                    fontSize: width * 0.035,
                    color: Colors.grey[600],
                  )),
            ),
          ),
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              children: [
                ProfileOptionTile(
                  title: "Privacy Policy",
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenConst.personalInformationScreen);
                  },
                ),
                SizedBox(height: height * 0.02),
                ProfileOptionTile(
                  title: "Terms & Conditions",
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenConst.personalInformationScreen);
                  },
                ),
                SizedBox(height: height * 0.02),
                ProfileOptionTile(
                  title: "FAQ & Support",
                  onTap: () {
                    Navigator.pushNamed(
                        context, ScreenConst.personalInformationScreen);
                  },
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Text("Sign Out",
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: const Color.fromARGB(255, 131, 36, 28),
                )),
          ),
        ]),
      ),
    );
  }
}
