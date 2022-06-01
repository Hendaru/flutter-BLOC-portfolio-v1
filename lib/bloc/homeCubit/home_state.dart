part of 'home_cubit.dart';

abstract class HomeCubitState extends Equatable {
  const HomeCubitState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeCubitState {}

class HomeLoadingState extends HomeCubitState {}

class HomeLoadedState extends HomeCubitState {
  late List<Data> lisDataEmployee;
  HomeLoadedState({required this.lisDataEmployee});
  @override
  List<Object> get props => [lisDataEmployee];
}

class HomeLoadMoreState extends HomeCubitState {
  // late List<Data> lisDataEmployee;
  // HomeLoadMoreState({required this.lisDataEmployee});
}

class HomeErrorState extends HomeCubitState {
  final String? errorMessage;
  HomeErrorState({this.errorMessage});
}
