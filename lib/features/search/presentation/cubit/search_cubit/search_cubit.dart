import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:homix/features/home/domain/entities/property_entity.dart';
import 'package:homix/features/search/presentation/dtos/search_result_dto.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchProperties(String query) async {
    try {
      emit(SearchLoading());

      final snapshot = await FirebaseFirestore.instance
          .collection('Apartments')
          .where('searchKeywords', arrayContains: query.toLowerCase())
          .get();

      if (snapshot.docs.isEmpty) {
        emit(SearchLoaded(results: []));
        return;
      }

      final results = snapshot.docs.map((doc) {
        final data = doc.data();
        return SearchResultDto(
          id: doc.id,
          title: data['title'] ?? '',
          location: data['location'] ?? '',
        );
      }).toList();

      emit(SearchLoaded(results: results));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }
}