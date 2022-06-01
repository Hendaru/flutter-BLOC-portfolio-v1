part of 'detailemployee_cubit.dart';

abstract class DetailEmployeeState extends Equatable {
  const DetailEmployeeState();

  @override
  List<Object> get props => [];
}

class DetailEmployeeInitial extends DetailEmployeeState {}

class DetailEmployeeLoadingState extends DetailEmployeeState {}

class DetailEmployeeErrorState extends DetailEmployeeState {}

class DetailEmployeeLoadedState extends DetailEmployeeState {
  late DetailEmployeeModel responBody;
  DetailEmployeeLoadedState({required this.responBody});
}
