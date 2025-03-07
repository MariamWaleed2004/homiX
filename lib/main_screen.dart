import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:homix/features/home_screen/home_screen.dart';
import 'package:homix/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if(getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
            body: Center(
              child: ElevatedButton(onPressed: (){
                BlocProvider.of<AuthCubit>(context).loggedOut();
                      Navigator.pushNamedAndRemoveUntil(context, ScreenConst.splashScreen, (route) => false);
              }, child: Text("SignOut")),
            ),
          // backgroundColor: Colors.white,
          // bottomNavigationBar: CupertinoTabBar(
          //   backgroundColor: Colors.black,
          //   items: [
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.home,
          //           color: Colors.white,
          //         ),
          //         label: ''),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.search,
          //           color: Colors.white,
          //         ),
          //         label: ''),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.add_circle,
          //           color: Colors.white,
          //         ),
          //         label: ''),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.favorite,
          //           color: Colors.white,
          //         ),
          //         label: ''),
          //     BottomNavigationBarItem(
          //         icon: Icon(
          //           Icons.person,
          //           color: Colors.white,
          //         ),
          //         label: ''),
          //   ],
          //   onTap: navigationTapped,
          // ),
          // body: PageView(
          //   controller: pageController,
          //   children: [
          //     HomeScreen(),
          //     ProfileScreen(),
          //   ],
          //   onPageChanged: onPageChanged,
          // ),
        );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
