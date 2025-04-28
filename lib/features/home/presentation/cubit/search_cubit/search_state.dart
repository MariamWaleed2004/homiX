part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchEmpty extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<QueryDocumentSnapshot> properties;

  const SearchLoaded(this.properties);

  @override
  List<Object> get props => [properties];
}

final class SearchError extends SearchState {
  final String errorMessage;
  const SearchError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
