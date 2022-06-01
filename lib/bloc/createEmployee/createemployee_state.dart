part of 'createemployee_cubit.dart';

abstract class CreateEmployeeState extends Equatable {
  const CreateEmployeeState();

  @override
  List<Object> get props => [];
}

class CreateEmployeeInitial extends CreateEmployeeState {}

class CreateEmployeeLoadingState extends CreateEmployeeState {}

class CreateEmployeeSuccessState extends CreateEmployeeState {
  late CreateEmployeeResponseModel responseBody;
  CreateEmployeeSuccessState({required this.responseBody});
}

class CreateEmployeeErrorState extends CreateEmployeeState {}
