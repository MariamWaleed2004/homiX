import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:homix/core/const.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/usecases/sign_in_user_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:homix/features/authentication/domain/usecases/sign_up_with_google.dart';
import 'package:homix/features/authentication/domain/usecases/sign_up_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUsecase signInUserUsecase;
  final SignUpUserUsecase signUpUserUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final SignUpWithGoogleUsecase signUpWithGoogleUsecase;
  CredentialCubit({
    required this.signInUserUsecase, 
    required this.signUpUserUsecase,
    required this.signInWithGoogleUsecase,
    required this.signUpWithGoogleUsecase,
  })
      : super(CredentialInitial());


      Future<void> signInUser({required String email, required String password,  required BuildContext context}) async {
        emit(CredentialLoading());
        try {
          await signInUserUsecase.call(UserEntity(email: email, password: password), context);
          emit(CredentialSuccess());
        } on SocketException catch (_) {
          emit(CredentialFailure(errorMessage: "No internet connection"));

        } on TimeoutException catch (e) {
           emit(CredentialFailure(errorMessage: e.message ?? "Request timed out."));
        } catch (e) {
          emit(CredentialFailure(errorMessage: "Signin failed: ${e.toString()}"));
        }
      }


      Future<void> signUpUser({required UserEntity user, required BuildContext context}) async {
        emit(CredentialLoading());
        try {
          await signUpUserUsecase.call(user, context).timeout(
           const Duration(seconds: 10),
            onTimeout: () {
              throw Exception("signUp process timed out");
            },
          );
          emit(CredentialSuccess());

        } on SocketException catch (_) {
          emit(CredentialFailure(errorMessage: "No internet connection"));

        } on TimeoutException catch (e) {
           emit(CredentialFailure(errorMessage: e.message ?? "Request timed out."));

        } catch (e) {
          emit(CredentialFailure(errorMessage: "Signup failed: ${e.toString()}"));

        }
      }


      Future<void> signUpWithGoogle(BuildContext context) async {
        emit(CredentialLoading());
        try {
          await signUpWithGoogleUsecase.call(context);
     
          emit(CredentialSuccess());

        } on SocketException catch (_) {
          emit(CredentialFailure(errorMessage: "No internet connection"));
        }
        catch (e) {
          emit(CredentialFailure(errorMessage: "Signup failed: ${e.toString()}"));
        }
      }


        Future<void> signInWithGoogle(BuildContext context) async {
        emit(CredentialLoading());
        try {
          await signInWithGoogleUsecase.call(context);
     
          emit(CredentialSuccess());
        } on SocketException catch (_) {
          emit(CredentialFailure(errorMessage: "No internet connection"));
        }
        catch (e) {
          emit(CredentialFailure(errorMessage: "Signup failed: ${e.toString()}"));
        }
      }
}
