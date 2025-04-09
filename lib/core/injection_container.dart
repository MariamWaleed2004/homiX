import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:homix/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:homix/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source_impl.dart';
import 'package:homix/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:homix/features/authentication/domain/repositories/auth_repo.dart';
import 'package:homix/features/authentication/domain/usecases/create_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/get_current_uid_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/get_single_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/get_users_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/is_sign_in_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/sign_in_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:homix/features/authentication/domain/usecases/sign_up_with_google.dart';
import 'package:homix/features/authentication/domain/usecases/sign_out_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/sign_up_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/update_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/upload_image_to_storage_usecase.dart';
import 'package:homix/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:homix/features/authentication/presentation/cubit/user_cubit/user_cubit.dart';

final sl = GetIt.instance;


Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => AuthCubit(
    signOutUserUsecase: sl.call(),
    isSignInUsecase: sl.call(),
    getCurrentUidUsecase: sl.call(),
     ));

     sl.registerFactory(
    () => CredentialCubit(
      signInUserUsecase: sl.call(),
      signUpUserUsecase: sl.call(),
      signUpWithGoogleUsecase: sl.call(),
      signInWithGoogleUsecase: sl.call(),
     ));

     sl.registerFactory(
    () => UserCubit(
      getUsersUsecase: sl.call(),
      updateUserUsecase: sl.call(),
     ));

      sl.registerFactory(
    () => GetSingleUserCubit(
      getSingleUserUsecase: sl.call(),
     ));


 
  // Use Cases
  sl.registerLazySingleton(() => SignOutUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpWithGoogleUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInWithGoogleUsecase(repository: sl.call()));
  //sl.registerLazySingleton(() => GetUsersUsecase(repository: sl.call()));


  // Cloud Storage
  sl.registerLazySingleton(() => UploadImageToStorageUsecase(repository: sl.call()));
  



  // Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authRemoteDataSource: sl.call()));

  //Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseFirestore: sl.call(), firebaseAuth: sl.call(), firebaseStorage: sl.call()));


  // Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}