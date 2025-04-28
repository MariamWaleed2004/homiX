import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SearchCubit() : super(SearchInitial());


  Future<void> searchApartments(String query) async {
    emit(SearchLoading());
    try {
      final result = await _firestore
          .collection('apartments')
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();    

      if (result.docs.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(result.docs));
      }
    } catch (e) {
      emit(SearchError('Failed to load search results'));
    }
  }

}
