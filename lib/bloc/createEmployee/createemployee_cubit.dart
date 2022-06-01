import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:transisi/model/createEmployeeModel.dart';
import 'package:transisi/model/createEmployeeResponseModel.dart';
import 'package:transisi/services/apiService.dart';

part 'createemployee_state.dart';

class CreateEmployeeCubit extends Cubit<CreateEmployeeState> {
  CreateEmployeeCubit() : super(CreateEmployeeInitial());

  Future createEmployee(String name, String job) async {
    try {
      emit(CreateEmployeeLoadingState());
      ApiService apiServices = ApiService();
      CreateEmployeeModel dataRequest =
          CreateEmployeeModel(name: name, job: job);
      Response? response = await apiServices.createEmployeeApi(dataRequest);
      print(response?.statusCode);
      if (response?.statusCode == 201) {
        var res = CreateEmployeeResponseModel.fromJson(response?.data);
        emit(CreateEmployeeSuccessState(responseBody: res));
      } else {
        emit(CreateEmployeeErrorState());
      }
    } catch (e) {
      emit(CreateEmployeeErrorState());
    }
  }
}
