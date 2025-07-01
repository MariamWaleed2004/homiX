part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

 
}

final class SearchInitial extends SearchState {
   @override
  List<Object> get props => [];
}


final class SearchLoading extends SearchState {
   @override
  List<Object> get props => [];
}




final class SearchLoaded extends SearchState {
  final List<SearchResultDto> results;

  const SearchLoaded({required this.results});

   @override
  List<Object> get props => [results];
}


final class SearchFailure extends SearchState {
  final String errorMessage;

  const SearchFailure(this.errorMessage);
    @override
  List<Object> get props => [errorMessage];
}