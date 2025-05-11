import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:homix/features/chat/presentation/screens/chat_screen.dart';
import 'package:homix/features/favorites/presentation/cubit/screens/favorites_screen.dart';
import 'package:homix/features/home/data/datasources/remote_data_sources/home_remote_data_source_impl.dart';
import 'package:homix/features/home/data/repositories/home_repo_impl.dart';
import 'package:homix/features/home/domain/usecases/get_property_usecase.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/home/presentation/screens/home_screen.dart';
import 'package:homix/features/profile/presentation/screens/profile_screen.dart';
import 'package:homix/features/search/presentation/screens/search_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

  void _onTap(int index) {
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  BottomNavigationBarItem buildTabTtem(IconData icon, int index) {
    bool isActive = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 8,
          ),
          Icon(
            icon,
            size: 26,
            color:
                isActive ? CupertinoColors.black : CupertinoColors.systemGrey,
          ),
          SizedBox(
            height: 3,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              color: isActive ? CupertinoColors.black : Colors.transparent,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
      //label: ''
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          'HomiX',
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              PhosphorIcons.bell(PhosphorIconsStyle.fill),
              color: Colors.black,
              size: 26,
            ),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, getSingleUserState) {
          if (getSingleUserState is GetSingleUserLoaded) {
            final currentUser = getSingleUserState.user;
            return CupertinoPageScaffold(
                child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  children: [
                    SearchScreen(),
                    FavoritesScreen(),
                    HomeScreen(),
                    // BlocProvider(
                    //   create: (context) => PropertyCubit(
                    //     getApartmentUsecase: GetApartmentUsecase(
                    //       repository: HomeRepoImpl(
                    //         homeRemoteDataSource: HomeRemoteDataSourceImpl(
                    //           firebaseFirestore: FirebaseFirestore.instance,)),
                    //       )
                    //   )..getProperties(),
                    //   child: HomeScreen(),
                    // ),
                    ChatScreen(),
                    ProfileScreen(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CupertinoTabBar(
                    border: Border(),
                    currentIndex: _currentIndex,
                    onTap: _onTap,
                    backgroundColor: Colors.grey[200],
                    items: [
                      buildTabTtem(PhosphorIconsRegular.magnifyingGlass, 0),
                      buildTabTtem(PhosphorIconsRegular.heart, 1),
                      buildTabTtem(PhosphorIconsRegular.house, 2),
                      buildTabTtem(PhosphorIconsRegular.chatCircle, 3),
                      buildTabTtem(PhosphorIconsRegular.user, 4),
                    ],
                  ),
                ),
              ],
            ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

    // Center(
    //           child: ElevatedButton(onPressed: (){
    //             BlocProvider.of<AuthCubit>(context).loggedOut();
    //                   Navigator.pushNamedAndRemoveUntil(context, ScreenConst.splashScreen, (route) => false);
    //           }, child: Text("SignOut")),
    //         ),
  }
}
