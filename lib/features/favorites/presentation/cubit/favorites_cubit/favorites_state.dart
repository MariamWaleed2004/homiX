part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();
}

final class FavoritesInitial extends FavoritesState {
  @override
  List<Object> get props => [];
}

final class FavoritesLoading extends FavoritesState {
  @override
  List<Object> get props => [];
}

final class FavoritesLoaded extends FavoritesState {
  final List<PropertyModel> favorites;
  const FavoritesLoaded(this.favorites);
  @override
  List<Object> get props => [];
}

final class FavoritesFailure extends FavoritesState {
  final String errorMessage;
  const FavoritesFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
