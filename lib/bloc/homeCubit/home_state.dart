part of 'home_cubit.dart';

abstract class HomeCubitState extends Equatable {
  const HomeCubitState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeCubitState {}

class HomeLoadingState extends HomeCubitState {}

class HomeLoadedState extends HomeCubitState {
  late ListDataEmployeeModel responseBody;
  HomeLoadedState({required this.responseBody});
}

class HomeErrorState extends HomeCubitState {
  final String? errorMessage;
  HomeErrorState({this.errorMessage});
}
