part of 'favorites_cubit.dart';


sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<PropertyModel> favorites;
  const FavoritesLoaded(this.favorites);
}

final class FavoritesFailure extends FavoritesState {
  final String errorMessage;
  const FavoritesFailure(this.errorMessage);
}
