import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homix/features/authentication/domain/entities/user_entity.dart';
import 'package:homix/features/authentication/domain/usecases/get_users_usecase.dart';
import 'package:homix/features/authentication/domain/usecases/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUsecase updateUserUsecase;
  final GetUsersUsecase getUsersUsecase;

  UserCubit({
    required this.updateUserUsecase, 
    required this.getUsersUsecase,
    }) : super(UserInitial());



    Future<void> getUsers({required UserEntity user}) async {
       try {
        final streamResponse = getUsersUsecase.call(user);
        streamResponse.listen((users) {
          emit(UserLoaded(users: users));
        });
       } on SocketException catch (_) {
        emit(UserFailure());
       } catch (_) {
        emit(UserFailure());
       }
    }



    Future<void> updateUser({required UserEntity user}) async {
        try {
          await updateUserUsecase.call(user);
        } on SocketException catch (_) {
          emit(UserFailure());
        } catch (e) {
          print("Error updating user: $e"); 
          emit(UserFailure());
        }
      }
}
