import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/domain/usecases/get_current_uid_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/is_sign_in_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/sign_out_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUserUsecase signOutUserUsecase;
  final IsSignInUsecase isSignInUsecase;
  final GetCurrentUidUsecase getCurrentUidUsecase;

  AuthCubit({
    required this.signOutUserUsecase,
    required this.isSignInUsecase,
    required this.getCurrentUidUsecase,
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUsecase.call();
      if (isSignIn == true) {
        final uid = await getCurrentUidUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUsecase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      toast("Invalid email or password");
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUserUsecase.call();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
