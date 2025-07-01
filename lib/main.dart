import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homix/core/on_generate_route.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:homix/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:homix/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:homix/features/authentication/presentation/screens/verification_screen.dart';
import 'package:homix/features/favorites/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:homix/features/home/domain/usecases/get_property_usecase.dart';
import 'package:homix/features/home/presentation/cubit/property_cubit/property_cubit.dart';
import 'package:homix/features/search/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:homix/main_screen.dart';
import 'package:homix/navigatorKey.dart';
import 'package:homix/splash_screen.dart';
import 'package:homix/core/injection_container.dart' as di;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(ScreenUtilInit(
    designSize: Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<PropertyCubit>()),
        BlocProvider(create: (_) => di.sl<FavoritesCubit>()),
        BlocProvider(create: (_) => di.sl<SearchCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[200],
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        onGenerateRoute: OnGenerateRoute.route,
        navigatorKey: navigatorKey,
        initialRoute: "/",
        routes: {
          "/": (context)
              //=> SplashScreen(),
              //=> MainScreen(uid: user!.uid,)
              {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                print("11111111111111${authState}");
                return MainScreen(uid: authState.uid);
              } else {
                return SplashScreen();
              }
            });
          }
        },
        //home: SignInScreen(),
      ),
    );
  }
}
