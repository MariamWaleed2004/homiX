part of 'property_cubit.dart';

sealed class PropertyState extends Equatable {
  const PropertyState();

}

final class PropertyInitial extends PropertyState {
    @override
  List<Object> get props => [];
}

final class PropertyLoading extends PropertyState {
    @override
  List<Object> get props => [];
}


final class PropertyLoaded extends PropertyState {
  final List<PropertyEntity> properties;

  PropertyLoaded({required this.properties});

    @override
  List<Object> get props => [properties];
}

final class PropertyFailure extends PropertyState {
  final String errorMessage;

  PropertyFailure(this.errorMessage);
    @override
  List<Object> get props => [errorMessage];
}